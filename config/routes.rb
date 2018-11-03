Rails.application.routes.draw do
  get 'freelancers/index'
  resources :chatrooms, module: "chatrooms" do
    resource :chatroom_users
    resource :messages
  end
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
  resources :messages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'freelancers#index'
  mount ActionCable.server => '/cable'
end
