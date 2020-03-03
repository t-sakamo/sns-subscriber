Rails.application.routes.draw do
  root to: 'sns_messages#index'

  resources :sns_messages, only: %s[index]
end
