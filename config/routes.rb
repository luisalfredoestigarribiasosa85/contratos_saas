Rails.application.routes.draw do
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
      get :success
      get :fail
    end
  end

  # Account management
  namespace :account do
    resource :plan, only: [ :show ] do
      get :checkout
    end
  end

  # Business features
  resources :companies, only: [ :show, :edit, :update ]
  resources :custom_templates, only: [ :index, :new, :create, :edit, :update, :destroy ]
  resources :support_tickets, only: [ :index, :new, :create, :show ]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
end
