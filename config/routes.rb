Rails.application.routes.draw do

  devise_for :users
  resources :teachers

  resources :students do
  	collection { post :import }
  end

  root 'students#index'

end
