Rails.application.routes.draw do

  resources :payout_identities

  get 'freelancer_searches',  controller: "freelancer_searches", action: "index"

  get 'profile_preview', controller: "profile_preview", action: "index"

  resources :certification_names, only: [:index]

  resources :healthcheck, only: [:index]

  resource :subscription_settings, only: [:show, :update]

  resources :chatrooms, module: "chatrooms" do
    resource :chatroom_users
    resource :messages
  end

  devise_for :users
  resources :photos
  resources :revenues
  resources :reservations
  resources :conversations
  resources :calendars
  resources :reviews

  resources :users do
    scope module: :users do
      resources :freelancers
    end
  end

  resources :freelancers do
    scope module: :freelancers do
      resources :payout_identities
    end
  end

  resources :messages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'freelancers#index'
  mount ActionCable.server => '/cable'
end
