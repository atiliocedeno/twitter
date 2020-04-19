Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
resources :tweets do
  member do
    post 'retweet'
  end
  resources :likes, only: [:create, :destroy]
end


     devise_for :users, controllers: {
       sessions: 'users/sessions'
     }
   resources :users, :only => [:show] do
    resources :follows
  end
root 'tweets#index'
get '/tweets/hashtags/:name', to: "tweets#hashtags"   
end