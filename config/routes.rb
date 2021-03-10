Rails.application.routes.draw do
  get 'notifications/show'
  get 'notifications/new'
  get 'studytimes/show'
  get 'studytimes/new'
  get 'subjects/new'
  get 'subjects/edit'
  get 'subjects/show'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'users/new'
  get 'sessions/new'
  root to: 'static_pages#home'
  get 'static_pages/home'
  get 'contact',to: 'static_pages#contact'
  get 'for_me',to: 'static_pages#for_me'
  get 'news',to: 'static_pages#news'
  get 'help',to: 'static_pages#help'
  get 'signup',to: 'users#new'
  get 'users/show'
  get 'login',to: 'sessions#new'
  post 'login',to: 'sessions#create'
  delete 'logout',to: 'sessions#destroy'
  delete 'subjects_delete',to: 'subjects#delete'
  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new,:create,:edit,:update]
  resources :subjects do
    collection do
      delete 'destroy_all'
    end
  end
  resources :studytimes
  resources :notifications
  resources :reminders,only: [:index]

end
