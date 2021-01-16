require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module CafeApp
  class Application < Rails::Application
    config.load_defaults 6.0

    # エラーメッセージの日本語化
    config.i18n.default_locale = :ja
    
    # herokuへのデプロイがうまくいかないので追記
    config.assets.initialize_on_precompile = false
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]
  end
end
