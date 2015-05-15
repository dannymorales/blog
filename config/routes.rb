Rails.application.routes.draw do
  
  # devise_for :admins
  devise_for :users
  resources :posts do
  	resources :comments
  end
  namespace :admin do
    get '', to: 'dashboard#index'
    resources :users
  end

  root 'posts#index'
end
