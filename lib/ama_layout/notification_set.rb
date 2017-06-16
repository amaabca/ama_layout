module AmaLayout
  class NotificationSet
    include Enumerable

    attr_accessor :notifications, :data_store, :key

    delegate :first, :last, :size, :[], to: :notifications

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
      args[:dismissed] = false
      notification = Notification.new(args)
      data_store.transaction do |store|
        self.notifications = notifications.push(notification).sort
        store.set(key, notifications.to_json)
      end
      self
    end

    def inspect
      "<#{self.class.name}>: #{notifications}"
    end
    alias_method :to_s, :inspect

    private

    def fetch
      result = data_store.get(key)
      if result.present?
        self.notifications = build_notifications(result)
      else
        self.notifications = []
      end
    end

    def build_notifications(raw)
      JSON.parse(raw)
        .inject([]) { |m, e| m << Notification.new(e) }
        .reject(&:dismissed?)
        .sort
    rescue JSON::ParserError
      data_store.delete(key) # we should try to prevent further errors
      ::Rails.logger.error json_message(__FILE__, __LINE__, raw)
      []
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
