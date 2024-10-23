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

  get    "login"   => "sessions#new"
  post   "login"   => "sessions#create"
  delete "logout"  => "sessions#destroy"

  get "logs/new_char"
  resources :logs
  post "logs/pre_new"
  get "logs/:id/preparing" => "logs#preparing", as: "log_preparing"
  get "logs/:id/logcontent" => "logs#log_content", as: "log_logContent"
  get "logs/:id/backlog" => "logs#backlog_content", as: "log_backlogContent"
  post "logs/:id/make_log_content" => "logs#make_log_content", as: "log_makeLogContent"

  resources :characters
  post "characters/create_pl"
  post "characters/:id/purge" => "characters#purge", as: "character_purge"

  resources :schedules
  resources :users

  get "*path", to: "application#page404", constraints: lambda { |req|
    !req.path.starts_with?("/rails/active_storage")
  }
end
