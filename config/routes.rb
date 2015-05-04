Rails.application.routes.draw do



  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :registrations => "users/registrations"}, :path_prefix => 'auth'
  


 # root 'users#index'
  root 'courses#index'

  resources :users do
    collection {post :import }
  end
  resources :courses do
    resources :teams do
      collection { post :import }
      resources :assignments, :except => ['new', 'create', 'edit', 'update', 'patch', 'destroy'] do
        resources :feedbacks
      end
    end
  end

  resources :users, :controller => "users"

  get 'courses/:course_id/assignments/new', to: 'assignments#new', :as => 'new_course_assignment'
  get 'courses/:course_id/assignments/:id/edit', to: 'assignments#edit', :as => 'edit_course_assignment'
  post 'courses/:course_id/assignments/', to: 'assignments#create'
  patch 'courses/:course_id/assignments/:id', to: 'assignments#update'
  put 'courses/:course_id/assignments/:id', to: 'assignments#update'
  get 'courses/:course_id/assignments/', to: 'assignments#professorindex', :as => 'all_assignments'
  delete 'courses/:course_id/assignments/:id', to: 'assignments#destroy', :as => 'delete_course_assignment'
  get 'courses/:course_id/assignments/:id', to: 'assignments#professorshow', :as => 'show_assignment'



end
