Rails.application.routes.draw do
  resources :edition_formats
  resources :distributors
  resources :editions
  resources :formats
  resources :packagings
  resources :regions
  root to: 'home#index'
end
