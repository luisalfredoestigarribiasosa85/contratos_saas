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

  # Account management
  namespace :account do
    resource :plan, only: [ :show ] do
      get :checkout
    end
  end

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
end
