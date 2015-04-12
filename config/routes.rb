Rails.application.routes.draw do
  root 'projects#index'

  resources :users
  get :profile, to: 'users#profile'

  resources :projects do
    member do
      get :invite_user
      post :add_user
    end

    resources :server_groups
  end
end
