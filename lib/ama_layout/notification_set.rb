module AmaLayout
  # An array-like object that handles the storage and retrieval of notifications
  # from the underlying data store.
  #
  # The raw serialization format is JSON as follows (keys are SHA256 hashes):
  #
  # {
  #   "02ac263cea5660e9f9020cb46e93772ed7755f2a60c40ad8961d2a15c1f99e6f": {
  #     "type": "notice",
  #     "header": "test",
  #     "content": "test",
  #     "created_at": "2017-06-19T11:26:57.730-06:00",
  #     "active": true,
  #     "version": "1.0.0"
  #   }
  # }
  #
  class NotificationSet
    include Enumerable

    attr_accessor :base, :data_store, :key

    delegate :first, :last, :size, :[], :empty?, :any?, to: :notifications

    def initialize(data_store, key)
      self.data_store = data_store
      self.key = "users/#{key}"
      fetch
    end

    def each(&block)
      notifications.each do |notification|
        block.call(notification)
      end
    end

    def create(args = {})
      args[:created_at] = Time.current
      args[:active] = true
      notification = Notification.new(args)
      notifications.push(notification)
      save
    end

    def find(digest)
      notifications.find { |n| n.id == digest }
    end

    def save
      data_store.transaction do |store|
        normalized = normalize(notifications)
        self.base = serialize(normalized)
        store.set(key, base.to_json)
      end
      reload!
    end

    def inspect
      "<#{self.class.name}>: #{notifications}"
    end
    alias_method :to_s, :inspect

    private

    def notifications
      @notifications ||= normalize(active_notifications)
    end

    def reload!
      @notifications = nil
      notifications
      self
    end

    def active_notifications
      base
        .inject([]) { |m, (k, v)| m << Notification.new(v.merge(id: k)) }
        .select(&:active?)
    end

    def serialize(data)
      data.inject({}) do |hash, element|
        # if there is already a dismissed notification, ignore it
        next if hash.has_key?(element.digest)
        hash[element.digest] = element.to_h
        hash
      end
    end

    def normalize(data)
      # sort by reverse chronological order
      data.sort { |a, b| b <=> a }
    end

    def fetch
      result = data_store.get(key)
      if result.present?
        self.base = build(result)
      else
        self.base = {}
      end
    end

    def build(raw)
      JSON.parse(raw)
    rescue JSON::ParserError
      data_store.delete(key) # we should try to prevent further errors
      ::Rails.logger.error json_message(__FILE__, __LINE__, raw)
      {}
    end

    def json_message(file, line, raw)
      {
        error: "#{self.class.name} - Invalid JSON",
        file: file,
        line: line,
        key: key,
        raw: raw
      }.to_json
    end
  end
end
