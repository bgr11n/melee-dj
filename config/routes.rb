Rails.application.routes.draw do
  #constraints: { nickname: /[^\/]+/ }

  root to: 'application#asd'

  resources :settings, controller: 'users/settings', only: [:index] do
    put :update, on: :collection
  end

  # Auth routes
  get 'sign_out', to: 'users/sign_in#destroy', as: 'sign_out'
  get 'sign_in', to: 'users/sign_in#new', as: 'sign_in'
  resources :sign_in, controller: 'users/sign_in', only: [:create]

  get 'twitch_callback', to: 'users/twitch_login#callback', as: 'twitch_callback'

  get 'sign_up', to: 'users/sign_up#new', as: 'sign_up'
  resources :sign_up, controller: 'users/sign_up', only: [:create]

end
