class Notifications {
  constructor() {
    // Get the notification root element from the DOM.
    this.notifications = $("[data-behavior='notifications']")

    if (this.notifications.length > 0) {
      // Get a list of notification items.
      this.updateUI(this.notifications.data("notifications"))

      // Listen for click event on the notification items.
      $("[data-behavior='notification-items']").on("click", (e) => {
        const { notificationId } = e.target.dataset
        this.handleClickNotificationLink(notificationId)
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
        this.updateUI(data)
      }
    })
  }

  // Marks the specified notification item as read.
  handleClickNotificationLink(notificationId) {
    $.ajax({
      url: `/notifications/${notificationId}/mark_as_read`,
      dataType: "JSON",
      method: "POST",
      success: (notifications) => {
        this.updateUI(notifications)
      }
    })
  }

  // Update UI with the specified set of notifications.
  updateUI(notifications) {
    // Convert notifications to template.
    const items = notifications.map(notification => {
      return notification.template
    })

    // Count unread notifications.
    let unread_count = 0
    notifications.forEach(notification => {
      if (notification.unread) { ++unread_count }
    })

    if (unread_count > 0) {
      document.querySelector('#unredCountDropdown').style.color = 'red'
    } else {
      document.querySelector('#unredCountDropdown').style.color = ''
    }

    // Update notification in the DOM.
    $("[data-behavior='unread-count']").text(unread_count)
    $("[data-behavior='notification-items']").html(items)
  }
}


// Initialize the notification when turbolinks is loaded.
document.addEventListener('turbolinks:load', () => {
  new Notifications()
})
