Rails.application.routes.draw do
  namespace :admin do
    resource :session, only: [:new, :create, :destroy]
  end

  resources :products, only: %i[index]

  root 'products#index'
end
