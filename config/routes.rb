Rails.application.routes.draw do
  get 'log_out', to: 'sessions#destroy', as: 'log_out'
  get 'log_in', to: 'sessions#new', as: 'log_in'
  resources :sessions

  get 'sign_up', to: 'users#new', as: 'sign_up'
  root to: 'users#new'
  resources :users
end
