Rails.application.routes.draw do
  namespace :admin do
    resources :support_tickets, only: [:index, :show, :update] do
      post :create_reply, on: :member
    end
  end
  devise_for :users

  # Public pages
  root "pages#home"
  get "pricing", to: "pages#pricing"

  # Authenticated root
  authenticated :user do
    get "dashboard", to: "dashboard#show", as: :authenticated_root
  end

  get "dashboard", to: "dashboard#show"

  resources :contract_templates, only: [ :index, :show ], path: "templates"
  resources :contracts, only: [ :index, :show, :new, :create, :destroy ]

  # Payment simulator (local development only — replace with Bancard routes later)
  resources :payment_simulators, only: [ :new, :create, :show ] do
    collection do
      post :success
      post :fail
    end
  end

  # Account management
  namespace :account do
    resource :plan, only: [ :show ] do
      get :checkout
      post :downgrade
    end
  end

  # Business features
  resources :companies, only: [ :show, :edit, :update ] do
    resources :company_invitations, only: [ :create, :destroy ], path: "invitations", module: :companies
    member do
      delete "remove_user", to: "companies#remove_user"
    end
  end
  resources :company_invitations, only: [] do
    member do
      post :accept
      post :decline
    end
    collection do
      get "accept/:token", to: "company_invitations#accept_via_token", as: :accept_via_token
      get "decline/:token", to: "company_invitations#decline_via_token", as: :decline_via_token
    end
  end
  resources :custom_templates, only: [ :index, :new, :create, :edit, :update, :destroy ]
  resources :support_tickets, only: [ :index, :new, :create, :show ] do
    post :create_reply, on: :member
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
end
