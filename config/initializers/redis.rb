redis = Rails.application.config.x.redis
$redis = Redis.new(
  host: redis[:host],
  port: redis[:port],
  password: redis[:password],
  db: redis[:db],
  ssl: true
)
