class NotificationsController < ApplicationController
  before_action :authenticate_user!

  # GET    /notifications.json
  def index
    # Get recent notifications addresed to current_user, whether read or not.
    @notifications = Notification.where(recipient: current_user).recent
  end

  # POST   /notifications/1/mark_as_read.json
  def mark_as_read
    # Mark as read the specified notification.
    notification = Notification.find(params[:id])
    notification.update!(read_at: Time.zone.now)

    # Send the updated JSON list of notification back to the browser.
    @notifications = Notification.where(recipient: current_user).recent
    render json: @notifications
  end
end
