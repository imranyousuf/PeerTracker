Rails.application.routes.draw do

  resources :students

  root 'students#index'

end
