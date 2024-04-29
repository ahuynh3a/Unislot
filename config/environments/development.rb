require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.after_initialize do
    Bullet.enable = true
    Bullet.sentry = true
    Bullet.alert = true
    Bullet.bullet_logger = true
    Bullet.console = true
    Bullet.xmpp = { :account  => 'bullets_account@jabber.org',
                    :password => 'bullets_password_for_jabber',
                    :receiver => 'your_account@jabber.org',
                    :show_online_status => true }
    Bullet.rails_logger = true
    Bullet.honeybadger = true
    Bullet.bugsnag = true
    Bullet.appsignal = true
    Bullet.airbrake = true
    Bullet.rollbar = true
    Bullet.add_footer = true
    Bullet.skip_html_injection = false
    Bullet.stacktrace_includes = [ 'your_gem', 'your_middleware' ]
    Bullet.stacktrace_excludes = [ 'their_gem', 'their_middleware', ['my_file.rb', 'my_method'], ['my_file.rb', 16..20] ]
    Bullet.slack = { webhook_url: 'http://some.slack.url', channel: '#default', username: 'notifier' }
  end

  # Allow server to be hosted on any URL
  config.hosts.clear
  config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }
  # Allow better_errors to work in online IDE
  config.web_console.whitelisted_ips = "0.0.0.0/0.0.0.0"
  BetterErrors::Middleware.allow_ip! "0.0.0.0/0.0.0.0"
  # Auto-connect to database when rails console opens
  console do
    ActiveRecord::Base.connection
  end
  # Settings specified here will take precedence over those in config/application.rb.


  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing
  config.server_timing = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :amazon

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true

  # Allow POST authenticity on Codespaces in dev
  config.action_controller.forgery_protection_origin_check = false
end
