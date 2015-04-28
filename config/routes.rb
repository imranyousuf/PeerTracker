Rails.application.routes.draw do

  #resources :assignments

  #resources :feedbacks

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users


 # root 'users#index'
  root 'courses#index'

  resources :users do
    collection {post :import }
  end
  resources :courses do
    resources :teams do
      collection { post :import }
      resources :assignments, :except => ['new', 'create', 'edit', 'update'] do
        resources :feedbacks
      end
    end
  end

  get 'courses/:id/assignments/new', to: 'assignments#new', :as => 'new_course_assignment'
  get 'courses/:id/assignments/:assignment_id/edit', to: 'assignments#edit', :as => 'edit_course_assignment'
  post 'courses/:id/assignments/', to: 'assignments#create'
  patch 'courses/:id/assignments/', to: 'assignments#update'
  put 'courses/:id/assignments/', to: 'assignments#update'
  get 'courses/:id/assignments/', to: 'assignments#professorindex', :as => 'all_assignments'



end
