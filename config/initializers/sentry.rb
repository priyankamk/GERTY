Raven.configure do |config|
  config.dsn = "https://#{ENV['SENTRY_APP_ID']}:#{ENV['SENTRY_APP_KEY']}@sentry.io/1428307"
end