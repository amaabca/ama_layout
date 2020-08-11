# frozen_string_literal: true

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
      return '' unless user

      h.render partial: ama_layout_partial('sign_out_link')
    end

    def member_links
      return '' unless user && %w[member member_renewal member_outstanding_balance].include?(user.try(:menu_key))

      h.render partial: ama_layout_partial('member_links')
    end

    def top_nav
      return '' unless user

      h.render partial: ama_layout_partial('top_nav'), locals: { navigation: self }
    end

    def top_logo
      return '' if user

      h.render partial: ama_layout_partial('top_logo'), locals: { navigation: self }

    end

    def sidebar
      return '' if items.none?

      h.render partial: ama_layout_partial('sidebar'), locals: { navigation: self }
    end

    def name_or_email
      display_name.present? ? "Welcome, #{display_name.titleize}" : email
    end

    def account_toggle(view_data = {})
      h(view_data).render partial: 'account_toggle'
    end

    def notification_icon
      return '' unless user

      h.render ama_layout_partial('notification_icon'), navigation: self
    end

    def mobile_notification_icon
      return '' unless user

      h.render ama_layout_partial('mobile_notification_icon'), navigation: self
    end

    def mobile_links
      return '' if user

      h.render ama_layout_partial('mobile_links')
    end

    def notification_badge
      return '' unless new_notifications?

      h.content_tag(
        :div,
        active_notification_count,
        class: 'notification__badge',
        data: {
          notification_count: true
        }
      )
    end

    def notification_sidebar
      return '' unless user

      h.render ama_layout_partial('notification_sidebar'), navigation: self, notifications: decorated_notifications
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
      active_notification_count.positive?
    end
  end
end
