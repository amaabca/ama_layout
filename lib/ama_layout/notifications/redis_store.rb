module AmaLayout
  module Notifications
    class RedisStore < AbstractStore
      delegate :clear, to: :base

      attr_accessor :base

      def initialize(opts = {})
        self.base = ActiveSupport::Cache.lookup_store(
          :redis_store,
          opts.merge(raw: true)
        )
      end

      def get(key, opts = {})
        if opts.fetch(:default, false)
          base.fetch(key) { opts[:default] }
        else
          base.read(key)
        end
      end

      def set(key, value, opts = {})
        base.write(key, value, opts)
      end

      def delete(key, opts = {})
        base.delete(key, opts)
      end

      def transaction
        base.data.multi do |pipeline|
          yield pipeline.self
        end
      end
    end
  end
end
