redis = Rails.application.config.x.redis

Sidekiq.configure_server do |config|
  config.redis = {
    url: "redis://#{redis[:host]}:#{redis[:port]}/#{redis[:db]}",
    password: redis[:password],
    ssl: redis[:ssl]
  }
end

Sidekiq.configure_client do |config|
  config.redis = {
    url: "redis://#{redis[:host]}:#{redis[:port]}/#{redis[:db]}",
    password: redis[:password],
    ssl: redis[:ssl]
  }
end
