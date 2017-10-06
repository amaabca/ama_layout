module AmaLayout
  class NavigationDecorator
    include AmaLayout::DraperReplacement

    def items
      object.items.map(&:decorate)
    end

    def display_name_text
      name_or_email.try(:truncate, 30)
    end

    def sign_out_link
      return "" unless user
      h.render partial: "ama_layout/sign_out_link"
    end

    def top_nav
      h.render partial: "ama_layout/top_nav", locals: { navigation: self } if user
    end

    def sidebar
      h.render partial: "ama_layout/sidebar", locals: { navigation: self } if items.any?
    end

    def name_or_email
      display_name.present? ? "Welcome, #{display_name.titleize}" : email
    end

    def account_toggle(view_data = {})
      h(view_data).render partial: "account_toggle"
    end

    def notification_icon
      if user
        h.render 'ama_layout/notification_icon', navigation: self
      end
    end

    def mobile_notification_icon
      if user
        h.render 'ama_layout/mobile_notification_icon', navigation: self
      end
    end

    def notification_badge
      if new_notifications?
        h.content_tag(
          :div,
          active_notification_count,
          class: 'notification__badge',
          data: {
            notification_count: true
          }
        )
      end
    end

    def notification_sidebar
      if user
        h.render 'ama_layout/notification_sidebar', navigation: self, notifications: decorated_notifications
      end
    end

    def notifications_heading
      if user.notifications.any?
        h.content_tag :p, 'Most Recent Notifications', class: 'mt1'
      else
        h.content_tag :p, 'No Recent Notifications', class: 'mt1 italic'
      end
    end

    private

    def decorated_notifications
      AmaLayout::NotificationDecorator.decorate_collection(user.notifications)
    end

    def active_notification_count
      user && user.notifications.active.size || 0
    end

    def new_notifications?
      active_notification_count > 0
    end
  end
end
