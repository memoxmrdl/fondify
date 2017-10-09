Rails.application.routes.draw do
  devise_for :admins, skip: [:passwords, :confirmations, :registrations, :omniauth_callbacks]
  devise_for :users

  root 'home#index'

  namespace :users do
    resources :projects
  end

  namespace :admins do
    resources :projects do
      resource :take, only: :create, controller: 'projects/take'
    end
  end
end
