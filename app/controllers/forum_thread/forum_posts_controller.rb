class ForumThread::ForumPostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_forum_thread

  def create
    @forum_post = @forum_thread.forum_posts.new(forum_post_params)
    @forum_post.user = current_user
    if @forum_post.save

      # Send the notifications to the rest of the users in this thread.
      recipients = (@forum_thread.users.uniq - [current_user])
      recipients.each do |recipient|
        Notification.posted(recipient: recipient, actor: current_user, notifiable: @forum_post)
      end

      flash[:notice] = "Successfully posted"
      redirect_to forum_thread_path(@forum_thread, anchor: "forum_post_#{@forum_post.id}")
    else
      render "forum_threads/show"
    end
  end

  private

    def set_forum_thread
      @forum_thread = ForumThread.find(params[:forum_thread_id])
    end

    def forum_post_params
      params.require(:forum_post).permit(:body)
    end
end
