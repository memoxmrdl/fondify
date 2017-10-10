Rails.application.routes.draw do
  devise_for :admins, skip: [:passwords, :confirmations, :registrations, :omniauth_callbacks], controllers: {
    sessions: 'admins/sessions'
  }

  namespace :admins do
    resources :projects do
      resource :take, only: :create, controller: 'projects/take'
      resource :accept, only: :create, controller: 'projects/accept'
      resources :notifications, only: :create, controller: 'projects/notifications'
    end
  end

  devise_for :users

  namespace :users do
    resources :projects
  end

  root 'home#index'
  resources :projects, only: [:index, :show]
end
