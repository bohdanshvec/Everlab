Rails.application.routes.draw do
  namespace :admin do
    resource :session, only: [:new, :create, :destroy]
    resources :products, except: %i[show]

  end

  root 'admin/products#index'

end
