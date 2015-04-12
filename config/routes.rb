Rails.application.routes.draw do
  root 'projects#index'

  resources :users
  get :profile, to: 'users#profile'

  resources :projects do
    member do
      get :new_user
      post :add_user
    end

    resources :server_groups do
      member do
        post :set_member
      end
    end
  end
end
