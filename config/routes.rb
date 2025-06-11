Rails.application.routes.draw do
  devise_for :users
  root "pages#home"

  # Profile routes
  resource :profile, only: [ :show, :edit, :update ]

  # Portfolio routes
  resources :portfolios
  get "freelancer/:id/portfolio", to: "portfolios#freelancer_portfolio", as: "freelancer_portfolio"

  # Project routes
  resources :projects do
    resources :project_proposals, only: [ :create ], path: "proposals"
  end

  # Project proposal routes
  resources :project_proposals, only: [ :show, :update, :destroy ], path: "proposals"

  # Health check
  get "up" => "rails/health#show", as: :rails_health_check

  # PWA routes
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
