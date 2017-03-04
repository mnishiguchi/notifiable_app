class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_notifications, if: :user_signed_in?
  around_action :set_time_zone

  include ForumPostsHelper

  private

    def set_notifications
      @notifications = Notification.includes([:notifiable, :actor])
                                   .where(recipient: current_user).recent
    end

    # Sets the time zone for the duration of a request.
    # When the request completes, the original time zone is set back.
    # https://robots.thoughtbot.com/its-about-time-zones
    def set_time_zone(&block)
      if cookies[:tz]
        puts "*" * 60
        puts "Time zone: #{cookies[:tz]}"
        puts "*" * 60
        Time.use_zone(cookies[:tz], &block)
      else
        # The around method must yield to execute the action.
        # http://guides.rubyonrails.org/action_controller_overview.html#after-filters-and-around-filters
        yield
      end
    end
end
