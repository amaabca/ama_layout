module AmaLayout
  class Notification
    TYPES = %i[notice warning alert].freeze
    FORMAT_VERSION = '1.0.0'.freeze

    # NOTE: The following attributes are designed to be immutable - you need
    # make a new instance to change them. The only mutable attribute is :active.
    attr_reader :id, :type, :header, :content, :created_at, :version
    attr_accessor :active

    def initialize(args = {})
      args = args.with_indifferent_access
      @id = args[:id]
      @type = args.fetch(:type, :notice).to_sym
      @header = args.fetch(:header)
      @content = args.fetch(:content)
      @created_at = parse_time(args.fetch(:created_at))
      @version = args.fetch(:version, FORMAT_VERSION)
      self.active = args.fetch(:active)
      invalid_type! if TYPES.exclude?(type)
    end

    def <=>(other)
      created_at <=> other.created_at
    end

    def active?
      active
    end

    def dismissed?
      !active?
    end

    def dismiss!
      self.active = false
      true
    end

    def digest
      Digest::SHA256.hexdigest(type.to_s + header + content + version)
    end

    def to_h
      {
        type: type,
        header: header,
        content: content,
        created_at: created_at,
        active: active,
        version: version
      }
    end

    private

    def invalid_type!
      raise ArgumentError, "invalid notification type: #{type}"
    end

    def parse_time(time)
      time.is_a?(String) ? Time.zone.parse(time) : time
    end
  end
end
