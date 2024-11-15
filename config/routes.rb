Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  require "sidekiq/web"
  mount Sidekiq::Web => "/sidekiq"

  root "logs#index"

  get    "login"   => "sessions#new"
  post   "login"   => "sessions#create"
  delete "logout"  => "sessions#destroy"

  get "logs/new_char"
  resources :logs
  post "logs/pre_new"
  get "logs/:id/preparing" => "logs#preparing", as: "log_preparing"
  get "logs/:id/logcontent" => "logs#log_content", as: "log_logContent"
  get "logs/:id/logview" => "logs#logview_content", as: "log_logviewContent"
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
