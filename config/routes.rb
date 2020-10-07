Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :tweets do
    resources :likes, only: [:create, :destroy]
  end

  devise_for :users
  resources :friends, only: [:create, :destroy], path: 'users/:user_id/friends'

  get 'api/news', to: 'tweets#api_news'
  get 'api/:fecha1/:fecha2', to: 'tweets#api_dates'
  post 'api/create_tweet/:email/:password/:content', to: 'tweets#api_create', constraints: { :email => /[^\/]+/ }

  root to: redirect("tweets")
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
