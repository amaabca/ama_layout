module AmaLayout
  module Api
    module V1
      class NotificationsController < ApplicationController
        before_action :require_login

        # DELETE /api/v1/notifications
        # Dismiss all user notifications
        def dismiss_all
          notifications = current_user.notifications
          notifications.each(&:dismiss!)
          notifications.save
          head :no_content
        end
      end
    end
  end
end
