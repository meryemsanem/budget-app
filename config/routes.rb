Rails.application.routes.draw do
  devise_for :users
  root 'splash_screen#index'
 
  resources :categories
end
