module AmaLayout
  class NavigationDecorator < Draper::Decorator
    delegate_all

    def items
      object.items.map { |i| i.decorate }
    end

    def display_name_text
      name_or_email.truncate(30)
    end

    def sign_out_link
      return "" unless user
      h.content_tag :li, class: "side-nav__item" do
        h.concat h.link_to "Sign Out", "/logout", class: "side-nav__link"
      end
    end

    def top_nav
      h.render partial: "ama_layout/top_nav", locals: { navigation: self } if items.any?
    end

    def sidebar
      h.render partial: "ama_layout/sidebar", locals: { navigation: self } if items.any?
    end

    def name_or_email
      display_name.present? ? "Welcome, #{display_name.titleize}" : email
    end

    def account_toggle
      h.render partial: "account_toggle"
    end

    def notifications
      if notifications?
        h.render 'ama_layout/notifications', notifications: user.notifications, navigation: self
      end
    end

    def notification_badge
      if badge?
        h.content_tag(
          :div,
          notification_count,
          class: 'notification__badge',
          data: {
            notification_count: true
          }
        )
      end
    end

    def notification_sidebar
      if notifications?
        h.render 'ama_layout/notification_sidebar', navigation: self, notifications: decorated_notifications
      end
    end

    def notifications_heading
      if user.notifications.size > 0
        h.content_tag :p, 'Most Recent Notifications', class: 'mt1'
      else
        h.content_tag(:p, 'No Recent Notifications', class: 'mt1 italic')
      end
    end

    private

    def decorated_notifications
      AmaLayout::NotificationDecorator.decorate_collection(user.notifications)
    end

    def notifications?
      user.present?
    end

    def notification_count
      notifications? && user.notifications.active.size || 0
    end

    def badge?
      notification_count > 0
    end
  end
end
