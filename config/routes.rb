Rails.application.routes.draw do
  devise_for :admins, skip: [:passwords, :confirmations, :registrations, :omniauth_callbacks]
  devise_for :users

  root 'home#index'
end
