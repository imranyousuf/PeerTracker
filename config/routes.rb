Rails.application.routes.draw do

  #resources :assignments

  #resources :feedbacks

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  #resources :instructors


  root 'users#index'

  resources :users do
    collection {post :import }
  end
  resources :courses do
    resources :teams do
      collection { post :import }
      resources :assignments do
        resources :feedbacks
      end
    end
  end

end
