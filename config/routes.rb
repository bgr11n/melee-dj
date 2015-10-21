Rails.application.routes.draw do

  root to: 'users/sign_up#new'

  get 'sign_out', to: 'users/sign_in#destroy', as: 'sign_out'
  get 'sign_in', to: 'users/sign_in#new', as: 'sign_in'
  resources :sign_in, to: 'users/sign_in', only: [:create]

  get 'sign_up', to: 'users/sign_up#new', as: 'sign_up'
  resources :sign_up, to: 'users/sign_up', only: [:create, :new]

end
