Rails.application.routes.draw do
  root 'application#index'

  resources :responses
  resources :forms do
    member do
      get 'input_token'
    end
  end

end
