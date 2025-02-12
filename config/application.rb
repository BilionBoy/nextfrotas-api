require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ApiMetricas
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.2

    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])
    config.autoload_paths += %W[#{config.root}/app/queries]


    config.time_zone = "La Paz" # Configuração do Time Zone

    # config.time_zone = "Central Time (US & Canada)"
    config.i18n.default_locale = :'pt-BR' # Configuração do idioma padrão


    # Configuração para uma aplicação apenas API
    config.api_only = true
  end
end
