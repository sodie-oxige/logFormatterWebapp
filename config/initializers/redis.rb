redis = Rails.application.config.x.redis
$redis = Redis.new(
  host: redis[:host],
  port: redis[:port],
  db: redis[:db]
)
