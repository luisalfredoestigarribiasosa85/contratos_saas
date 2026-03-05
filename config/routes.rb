Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root "dashboard#show", as: :authenticated_root
  end

  devise_scope :user do
    root "devise/sessions#new"
  end

  get "dashboard", to: "dashboard#show"

  resources :contract_templates, only: [ :index, :show ], path: "templates"
  resources :contracts, only: [ :index, :show, :new, :create, :destroy ]

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  get "up" => "rails/health#show", as: :rails_health_check
end
