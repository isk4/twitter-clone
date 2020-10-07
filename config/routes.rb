Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :tweets do
    resources :likes, only: [:create, :destroy]
  end

  devise_for :users
  resources :friends, only: [:create, :destroy], path: 'users/:user_id/friends'

  get 'api/news', to: 'tweets#api_news'

  root to: redirect("tweets")
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
