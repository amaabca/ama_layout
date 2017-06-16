module AmaLayout
  # Usage:
  #
  # class MyClass
  #   include AmaLayout::Notifications
  #
  #   notification_store AmaLayout::Notifications::RedisStore.new(options)
  #   notification_foreign_key :a_method_name_or_proc # defaults to :id
  #
  #   ...
  # end
  #
  module Notifications
    InvalidNotificationStore = Class.new(StandardError)

    def self.included(base)
      base.extend(ClassMethods)
      base.include(InstanceMethods)
    end

    module InstanceMethods
      def notifications
        @notifications ||= NotificationSet.new _store, _foreign_key
      end

      def notifications=(other)
        @notifications = other
      end

      private

      def _store
        self.class._notification_store || invalid_store!
      end

      def _foreign_key
        self.class._notification_foreign_key.call(self)
      end

      def invalid_store!
        raise InvalidNotificationStore, 'a notification store must be specified'
      end
    end

    module ClassMethods
      def notification_store(store)
        self._notification_store = store
      end

      def notification_foreign_key(key)
        self._notification_foreign_key = key
      end

      def _notification_foreign_key
        @_notification_foreign_key || Proc.new { |m| m.id }
      end

      def _notification_store
        @_notification_store
      end

      private

      def _notification_store=(store)
        @_notification_store = store
      end

      def _notification_foreign_key=(key)
        @_notification_foreign_key = key.to_proc
      end
    end
  end
end
