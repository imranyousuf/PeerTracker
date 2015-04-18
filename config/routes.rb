Rails.application.routes.draw do

  #resources :assignments

  #resources :feedbacks

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  #resources :instructors


  
  #resources :students do
  #	collection { post :import }
  #  end

  root 'users#index'

  resources :users
  resources :courses do
    resources :teams do
      resources :assignments do
        resources :feedback_givens, :feedback_receiveds
      end
    end
  end

end
