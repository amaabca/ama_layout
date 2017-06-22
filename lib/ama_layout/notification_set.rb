module AmaLayout
  # An array-like object that handles the storage and retrieval of notifications
  # from the underlying data store.
  #
  # The raw serialization format is JSON as follows (keys are SHA256 hashes):
  #
  # {
  #   "8ca9f850c18acc17643038b2341bee3ede8a24c0f3e92f56f2109ce49fdcb616": {
  #     "type": "notice",
  #     "header": "test",
  #     "content": "test",
  #     "created_at": "2017-06-19T11:26:57.730-06:00",
  #     "lifespan": 31557600,
  #     "active": true,
  #     "version": "1.0.0"
  #   }
  # }
  #
  class NotificationSet
    include Enumerable
    attr_accessor :base, :data_store, :key

    delegate :each, :first, :last, :size, :[], :empty?, :any?,  to: :active

    def initialize(data_store, key)
      self.data_store = data_store
      self.key = key
      self.base = fetch
      clean!
    end

    def active
      all.select(&:active?)
    end

    def all
      @all ||= normalize(base_notifications)
    end

    def create(args = {})
      args[:created_at] = Time.current
      args[:active] = true
      notification = Notification.new(args)
      # previously dismissed notifications always take precendence
      all.push(notification) unless base.key?(notification.digest)
      save
    end

    def destroy!
      data_store.delete(key) && reload!
    end

    def find(digest)
      all.find { |n| n.id == digest }
    end

    def save
      data_store.transaction do |store|
        normalized = normalize(all)
        self.base = serialize(normalized)
        store.set(key, base.to_json)
      end
      reload!
    end

    def inspect
      "<#{self.class.name}>: #{all}"
    end
    alias_method :to_s, :inspect

    private

    def clean!
      if dirty?
        all.reject!(&:stale?)
        save
      end
    end

    def dirty?
      all.any?(&:stale?)
    end

    def reload!
      @all = nil
      self.base = fetch
      all
      self
    end

    def base_notifications
      base.map { |k, v| Notification.new(v.merge(id: k)) }
    end

    def serialize(data)
      data.inject({}) do |hash, element|
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
      result.present? ? build(result) : {}
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
