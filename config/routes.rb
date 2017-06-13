Rails.application.routes.draw do
  resources :distributors
  resources :editions
  resources :formats
  resources :packagings
  root to: 'home#index'
end
