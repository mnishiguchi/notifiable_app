class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_notifications, if: :user_signed_in?

  include ForumPostsHelper

  def set_notifications
    @notifications = Notification.where(recipient: current_user).recent
  end
end
