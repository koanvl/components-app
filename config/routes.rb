Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  # Profile routes
  resource :profile, only: [ :show, :edit, :update ]

  # Portfolio routes (only for freelancers)
  resources :portfolios, except: [ :index ]

  # Public portfolio viewing
  get "freelancer/:id/portfolio", to: "portfolios#freelancer_portfolio", as: "freelancer_portfolio"

  # Root route
  # root "home#index"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "pages#home"
  # get 'drafts/invoice', to: 'drafts#invoice'
end
