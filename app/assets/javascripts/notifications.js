class Notifications {
  constructor() {
    // Get the notification root element from the DOM.
    this.notifications = $("[data-behavior='notifications']")

    if (this.notifications.length > 0) {
      // Get a list of notification items.
      this.updateUI(this.notifications.data("notifications"))

      // Subscribe click event on the dropdown toggle.
      $("[data-behavior='notifications-link']").on("click", () => {
        this.handleClickNotificationLink()
      })

      // Fetch notifications from the server every 5 seconds.
      setInterval(() => {
        this.getNewNotifications()
      }, 5000)
    }
  }

  // Fetch notifications from the server.
  getNewNotifications() {
    $.ajax({
      url: "/notifications.json",
      dataType: "JSON",
      method: "GET",
      success: (data) => {

        console.log(data)

        this.updateUI(data)
      }
    })
  }

  // Marks the notification as read.
  handleClickNotificationLink(e) {
    $.ajax({
      url: "/notifications/mark_as_read",
      dataType: "JSON",
      method: "POST",
      success: () => {
        // Reset the unread-count to 0.
        setTimeout(() => {
          $("[data-behavior='unread-count']").text(0)
        }, 1000)
      }
    })
  }

  // Update UI with the specified set of notifications.
  updateUI(data) {
    // Convert notifications to template.
    const items = data.map(notification => {
      return notification.template
    })

    // Count unread notifications.
    let unread_count = 0
    data.forEach(notification => {
      if (notification.unread) {
        unread_count += 1
      }
    })

    // Update notification in the DOM.
    $("[data-behavior='unread-count']").text(unread_count)
    $("[data-behavior='notification-items']").html(items)
  }
}


// Initialize the notification when turbolinks is loaded.
document.addEventListener('turbolinks:load', () => {
  new Notifications()
})
