sidekiq_config = { url: ENV["REDIS_URL"] }

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end
