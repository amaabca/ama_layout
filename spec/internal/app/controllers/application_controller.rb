class ApplicationController < ActionController::Base
  class NotificationsStub
    include Enumerable

    def each
      [OpenStruct.new(dismiss!: true)].each do |element|
        yield element
      end
    end

    def save
      true
    end
  end

  def require_login
    @current_user = OpenStruct.new(notifications: NotificationsStub.new)
  end

  def current_user
    @current_user
  end
end
