Rails.application.routes.draw do

  devise_for :users

  # forum_posts are always accessed with their parent forum thread.
  resources :forum_threads do
    resources :forum_posts, module: :forum_thread
  end

  resources :notifications do
    member do
      post :mark_as_read
    end
  end

  root "forum_threads#index"
end
