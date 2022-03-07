Rails.application.routes.draw do
  root 'application#index'

  resources :responses
  resources :forms
end
