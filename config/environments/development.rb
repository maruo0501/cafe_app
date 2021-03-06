Rails.application.configure do
  config.after_initialize do
    Bullet.enable = true # Bulletを有効化
    Bullet.alert = true # JavaScriptのポップアップアラートを有効化
    Bullet.bullet_logger = true # Rails.root/log/bullet.logに出力
    Bullet.console = true # ブラウザのconsole.logに出力
    Bullet.rails_logger = true # Railsのログに結果を出力
    Bullet.add_footer = true # ページの左下に結果を表示
  end

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable/disable caching. By default caching is disabled.
  if Rails.root.join('tmp', 'caching-dev.txt').exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true
    config.cache_store = :memory_store
    config.public_file_server.headers = {
      'Cache-Control' => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false
    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :local

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  config.assets.debug = true

  config.assets.quiet = true

  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
