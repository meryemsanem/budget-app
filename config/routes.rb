Rails.application.routes.draw do
  devise_for :users
  
   authenticated :user do
    root "categories#index", as: :authenticated_root
  end

  unauthenticated do
    root "splash_screen#index", as: :unauthenticated_root
  end
 
resources :categories do
  resources :transactions
end
end