class Notifications
  constructor: ->
    # Get the notification root element from the DOM.
    @notifications = $("[data-behavior='notifications']")

    if @notifications.length > 0
      # Get a list of notification items.
      @updateUI @notifications.data("notifications")

      # Subscribe click event on the dropdown toggle.
      $("[data-behavior='notifications-link']").on "click", @handleClickNotificationLink

      # Fetch notifications from the server every 5 seconds.
      setInterval (=>
        @getNewNotifications()
      ), 5000

  # Fetch notifications from the server.
  getNewNotifications: ->
    $.ajax(
      url: "/notifications.json"
      dataType: "JSON"
      method: "GET"
      success: @updateUI
    )

  # Marks the notification as read.
  handleClickNotificationLink: (e) =>
    $.ajax(
      url: "/notifications/mark_as_read"
      dataType: "JSON"
      method: "POST"
      success: ->
        # Reset the unread-count to 0.
        setTimeout (=>
          $("[data-behavior='unread-count']").text(0)
        ), 1000
    )

  # Update UI with the specified set of notifications.
  updateUI: (data) =>
    # Convert notifications to template.
    items = $.map data, (notification) ->
      notification.template

    # Count unread notifications.
    unread_count = 0
    $.each data, (i, notification) ->
      if notification.unread
        unread_count += 1

    # Update notification in the DOM.
    $("[data-behavior='unread-count']").text(unread_count)
    $("[data-behavior='notification-items']").html(items)

# Initialize the notification when turbolinks is loaded.
$(document).on 'turbolinks:load', ->
  new Notifications
