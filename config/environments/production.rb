Memorybox::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb

  # Code is not reloaded between requests
  config.cache_classes = true

  # Full error reports are disabled and caching is turned on
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true

  # Disable Rails's static asset server (Apache or nginx will already do this)
  config.serve_static_assets = false

  # Compress JavaScripts and CSS
  config.assets.compress = true

  # Don't fallback to assets pipeline if a precompiled asset is missed
  #config.assets.compile = false

  # Generate digests for assets URLs
  config.assets.digest = true

  # User cloudfront as deployment asset host
  config.action_controller.asset_host = ENV['ASSET_HOST']

  config.static_cache_control = "public, max-age=334820"

  config.logger = Logger.new(STDOUT)

  # Enable locale fallbacks for I18n (makes lookups for any locale fall back to
  # the I18n.default_locale when a translation can not be found)
  config.i18n.fallbacks = true

  # Send deprecation notices to registered listeners
  config.active_support.deprecation = :notify

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  # config.active_record.auto_explain_threshold_in_seconds = 0.5

  config.action_mailer.default_url_options = { host: "www.memoryboxapp.com" }

  ActionMailer::Base.smtp_settings = {
    address: 'smtp.gmail.com',
    port: '587',
    authentication: :plain,
    user_name: ENV['GMAIL_USER'],
    password: ENV['GMAIL_PASSWORD'],
    domain: 'www.memoryboxapp.com',
    enable_starttls_auto: true
}

end
