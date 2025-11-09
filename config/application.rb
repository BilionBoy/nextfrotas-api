require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module NextFrotasApi
  class Application < Rails::Application
    # Rails version.
    config.load_defaults 7.2

    config.autoload_paths += %W[#{config.root}/lib]               # Adiciona diretórios ao autoload do Rails em desevolvimento
    config.autoload_lib(ignore: %w[assets tasks])

    config.time_zone = "La Paz"                                   # Configuração do Time Zone
    config.i18n.default_locale = :'pt-BR'                         # Configuração do idioma padrão

    config.api_only = true
  end
end
