Rails.application.routes.draw do
  root to: 'application#home'

  resource :settings, only: [] do
    root to: 'users/settings/profiles#show'
    resource :profile, controller: 'users/settings/profiles', only: [:show, :update]
    resource :party, controller: 'users/settings/parties', only: [:new, :create, :show, :update]
  end

  # Auth routes
  get 'sign_out', to: 'users/sign_in#destroy', as: 'sign_out'
  get 'sign_in', to: 'users/sign_in#new', as: 'sign_in'
  resources :sign_in, controller: 'users/sign_in', only: [:create]

  get 'twitch_callback', to: 'users/twitch_login#callback', as: 'twitch_callback'

  get 'sign_up', to: 'users/sign_up#new', as: 'sign_up'
  resources :sign_up, controller: 'users/sign_up', only: [:create]

  # Party routes
  resources :chat, controller: 'parties/chat', only: [] do
    resources :messages, only: [:index, :create], controller: 'parties/messages'
  end
  get '/:nickname', to: 'parties#show', constraints: { nickname: /[^\/]+/ }, as: :show_party
end
