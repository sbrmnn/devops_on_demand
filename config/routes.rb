Rails.application.routes.draw do


  resources :cloud_services, only: :index

  resource :chatrooms, only: :create

  get 'freelancer_searches',  controller: "freelancer_searches", action: "index"

  get 'profile_preview', controller: "profile_preview", action: "index"


  resources :certification_names, only: [:index]

  resources :healthcheck, only: [:index]
  resource :email_relay_mapper, only: [:show]
  resource :subscription_settings, only: [:show, :update]

  resources :chatrooms, module: "chatrooms" do
    resource :chatroom_users
    resource :messages
  end

  resources :webhooks

  devise_for :users
  resources :photos
  resources :revenues
  resource :reservations, only: [:new, :create, :update]
  resources :conversations
  resources :calendars
  resources :reviews

  resources :users do
    scope module: :users do
      resources :freelancers
      resource :settings, only: [:create, :update]
      resource :credit_cards, only: [:show, :create, :update]
      resource :jobs, only: [:new, :show, :create, :update]
    end
  end

  resources :freelancers


  resource :freelancers do
    scope module: :freelancers do
      resources :payout_identities, only: [:update, :create]
      resources :job_approvals, only: :update
    end
  end

  resources :messages
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'freelancers#index'
  mount ActionCable.server => '/cable'
end
