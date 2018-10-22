Rails.application.routes.draw do
  get 'freelancers/index'

  resources :freelancers
  get 'users/show'

  devise_for :users
  resources :photos
  resources :revenues
  resources :reservations
  resources :conversations
  resources :calendars
  resources :reviews
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'freelancers#index'
end
