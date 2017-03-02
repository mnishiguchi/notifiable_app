class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_notifications, if: :user_signed_in?
  around_action :set_time_zone

  include ForumPostsHelper

  private

    def set_notifications
      @notifications = Notification.where(recipient: current_user).recent
    end

    # Sets the time zone for the duration of a request.
    # When the request completes, the original time zone is set back.
    # https://robots.thoughtbot.com/its-about-time-zones
    def set_time_zone(&block)
      ap "timezone is set to #{cookies[:timezone]}"
      Time.use_zone(cookies[:timezone], &block) if cookies[:timezone]
    end
end
