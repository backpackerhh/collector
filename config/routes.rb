Rails.application.routes.draw do
  resources :distributors
  resources :formats
  root to: 'home#index'
end
