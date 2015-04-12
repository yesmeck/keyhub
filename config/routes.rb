Rails.application.routes.draw do
  root 'home#index'

  resources :users
  get :profile, to: 'users#profile'

  resources :projects
end
