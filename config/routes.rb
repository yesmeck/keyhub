Rails.application.routes.draw do
  root 'projects#index'

  resources :users
  get :profile, to: 'users#profile'
  get :configure, to: 'server_groups#configure'

  resources :projects do
    member do
      get :new_user
      post :add_user
    end

    resources :server_groups do
      member do
        post :set_member
        get :deploy
      end
    end
  end
end
