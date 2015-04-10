Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :teachers

  resources :students do
  	collection { post :import }
  end

  root 'students#index'

end
