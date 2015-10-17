Rails.application.routes.draw do
  root 'bots#index'
  resources :bots do
    member do
      get :storage, to: 'bots#show_storage'
      get :hook, to: 'bots#hook'
      post :hook, to: 'bots#hook'
    end
  end

  resources :bot_modules

  get '/auth/:provider/callback', to: 'sessions#create'
  resource :sessions, only: [:new, :destroy]

  mount Webhook::API => '/webhook'
end
