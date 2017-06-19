Rails.application.routes.draw do
  resources :distributors
  resources :editions
  resources :formats
  resources :packagings
  resources :regions
  root to: 'home#index'
end
