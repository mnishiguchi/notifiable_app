class ForumThreadsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_forum_thread, only: [:show, :edit, :update, :destroy]

  def index
    @forum_threads = ForumThread.all
  end

  def show
    @forum_post = ForumPost.new
  end

  def new
    @forum_thread = ForumThread.new

    # A forum_post instance in memory for nesting it in the form.
    @forum_thread.forum_posts.new
  end

  def create
    # Set user_id on the new forum_thread and forum_post.
    # NOTE: Because these must be associated with current_user, it is a good idea
    # to hard-code the logic here rather than do it in the HTML form.
    @forum_thread = current_user.forum_threads.new(forum_thread_params)
    @forum_thread.forum_posts.first.user_id = current_user.id

    if @forum_thread.save
      redirect_to @forum_thread
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @forum_thread.update(forum_thread_params)
      redirect_to @forum_thread
    else
      render action: :edit
    end
  end

  def destroy
    @forum_thread.destroy
    redirect_to forum_threads_path
  end

  private

    def set_forum_thread
      @forum_thread = ForumThread.find(params[:id])
    end

    def forum_thread_params
      params.require(:forum_thread).permit(:title, forum_posts_attributes: [:id, :body])
    end
end
