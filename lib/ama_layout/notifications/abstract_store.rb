module AmaLayout
  module Notifications
    class AbstractStore
      def get(key, opts = {})
        raise NotImplementedError, 'you must define a #get method in a subclass'
      end

      def set(key, value, opts = {})
        raise NotImplementedError, 'you must define a #set method in a subclass'
      end

      def delete(key, opts = {})
        raise NotImplementedError, 'you must define a #delete method in a subclass'
      end
    end
  end
end
