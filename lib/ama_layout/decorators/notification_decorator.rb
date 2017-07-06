module AmaLayout
  class NotificationDecorator < Draper::Decorator
    delegate_all

    ICONS = {
      notice: {
        icon_class: 'fa-info',
        colour_class: 'right-sidebar__content-icon--blue' # currently not in use
      },
      warning: {
        icon_class: 'fa-exclamation',
        colour_class: 'right-sidebar__content-icon--orange'
      },
      alert: {
        icon_class: 'fa-exclamation-triangle',
        colour_class: 'right-sidebar__content-icon--red'
      }
    }.freeze

    def created_at
      "#{time_elapsed} ago".humanize
    end

    def icon
      h.content_tag :div, class: icon_data.fetch(:colour_class) do
        klass = icon_data.fetch(:icon_class)
        h.content_tag :i, nil, class: "fa #{klass} right-sidebar__notice-icon"
      end
    end

    def active_class
      active? ? 'right-sidebar__content--active' : 'right-sidebar__content--inactive'
    end

    private

    def icon_data
      @icon_data ||= ICONS.fetch(type)
    end

    def time_elapsed
      h.time_ago_in_words(object.created_at, include_seconds: true)
    end
  end
end
