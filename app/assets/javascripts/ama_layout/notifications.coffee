class AMALayout.Notifications
  constructor: () ->
    $(document).on 'click', '[data-notifications-toggle]', (event) =>
      event.preventDefault();
      badge = event.currentTarget
      if $(badge).find('[data-notification-count]').remove().size()
        @request()

  request: () ->
    $.ajax(
      type: 'DELETE',
      url: '/ama_layout/api/v1/notifications',
      timeout: 10000
    )

$(document).ready ->
  window.AMALayout.notifications = new AMALayout.Notifications()
