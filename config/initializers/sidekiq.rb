Sidekiq.configure_server do |config|
  config.redis = { namespace: 'hcxp' }
end

Sidekiq.configure_client do |config|
  config.redis = { namespace: 'hcxp' }
end