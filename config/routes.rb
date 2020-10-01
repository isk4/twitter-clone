Rails.application.routes.draw do
  resources :tweets do
    resources :likes, only: [:create, :destroy]
  end
  devise_for :users

  root to: redirect("tweets")
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
