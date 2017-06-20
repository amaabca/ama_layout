module AmaLayout
  class Notification
    TYPES = %i[notice warning alert].freeze
    DEFAULT_LIFESPAN = 1.year.freeze
    FORMAT_VERSION = '1.0.0'.freeze

    # NOTE: The following attributes are designed to be immutable - you need
    # make a new instance to change them. The only mutable attribute is :active.
    attr_reader :id, :type, :header, :content, :created_at, :lifespan, :version
    attr_accessor :active

    def initialize(args = {})
      args = args.with_indifferent_access
      @id = args[:id]
      @type = args.fetch(:type, :notice).to_sym
      @header = args.fetch(:header)
      @content = args.fetch(:content)
      @created_at = parse_time(args.fetch(:created_at))
      @lifespan = parse_duration(args.fetch(:lifespan, DEFAULT_LIFESPAN))
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
      dismissed?
    end

    def digest
      Digest::SHA256.hexdigest(
        "#{type}#{header}#{content}#{lifespan.to_i}#{version}"
      )
    end

    def stale?
      Time.current > created_at + lifespan
    end

    def to_h
      # NOTE: We want the following keys to be strings to provide
      # consistency with the underlying data store.
      {
        'type' => type.to_s,
        'header' => header,
        'content' => content,
        'created_at' => created_at.iso8601,
        'active' => active,
        'lifespan' => lifespan.to_i,
        'version' => version
      }
    end

    private

    def invalid_type!
      raise ArgumentError, "invalid notification type: #{type}"
    end

    def parse_time(time)
      time.is_a?(String) ? Time.zone.parse(time) : time
    end


    def parse_duration(duration)
      if duration.is_a?(ActiveSupport::Duration)
        duration
      else
        duration.public_send(:seconds)
      end
    end
  end
end
