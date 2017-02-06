class NotificationsController < ApplicationController
  before_action :authenticate_user!

  # GET    /notifications.json
  def index
    # Get recent notifications addresed to current_user, whether read or not.
    @notifications = Notification.where(recipient: current_user).recent
  end

  # POST   /notifications/mark_as_read.json
  def mark_as_read
    @notifications = Notification.where(recipient: current_user).unread
    @notifications.update_all(read_at: Time.zone.now)
    render json: { success: true }
  end
end
