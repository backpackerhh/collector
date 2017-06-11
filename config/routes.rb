Rails.application.routes.draw do
  resources :distributors
  root to: 'home#index'
end
