module AmaLayout
  class Notification
    TYPES = %i(notice warning alert).freeze
    # NOTE: We should probably add a version attribute as we may want to
    # make breaking changes to the marshal format eventually...
    attr_accessor :type, :header, :content, :created_at, :dismissed, :priority

    def initialize(args = {})
      args = args.with_indifferent_access
      self.type = args.fetch(:type, TYPES.first)
      self.header = args.fetch(:header)
      self.content = args.fetch(:content)
      self.created_at = args.fetch(:created_at)
      self.dismissed = args.fetch(:dismissed)
      self.priority = args.fetch(:priority)
    end

    def <=>(other)
      priority <=> other.priority
    end

    def dismissed?
      dismissed
    end

    def created_at=(time)
      if time.is_a?(String)
        @created_at = Time.zone.parse(time)
      else
        @created_at = time
      end
    end
  end
end
