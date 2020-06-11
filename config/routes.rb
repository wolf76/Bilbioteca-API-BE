Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  resources :books do
    member do
      get :users
    end
  end

  resources :users

  resources :groups do
    member do
      get :users
      get :books
    end
  end
end
