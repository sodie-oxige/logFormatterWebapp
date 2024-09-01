Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "logs#index"

  get "logs/new_char"
  resources :logs
  post "logs/pre_new"
  get "logs/:id/preparing" => "logs#preparing", as: "log_preparing"
  post "logs/:id/make_json" => "logs#make_json", as: "log_makejson"

  resources :characters
  post "characters/create_pc"
  post "characters/create_pl"
  post "characters/:id/purge" => "characters#purge", as: "character_purge"

  resources :schedules
end
