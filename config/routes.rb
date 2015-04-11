Rails.application.routes.draw do

  resources :assignments

  resources :feedbacks

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  resources :instructors

  resources :students do
  	collection { post :import }
  end

  root 'students#index'

end
