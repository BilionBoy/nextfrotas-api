require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module ApiMetricas
  class Application < Rails::Application

    # Rails version.
    config.load_defaults 7.2

    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.generators do |g|
      g.scaffold_controller "scaffold/api/controller"            # Aqui informamos o caminho do gerador
    end
    config.autoload_lib(ignore: %w[assets tasks])
    config.autoload_paths += %W[#{config.root}/app/queries]

    config.time_zone = "La Paz"                                   # Configuração do Time Zone
    config.i18n.default_locale = :'pt-BR'                         # Configuração do idioma padrão

    config.autoload_paths += Dir[Rails.root.join("lib", "**/")]   # Certificando que subpastas sejam carregadas
    config.eager_load_paths += Dir[Rails.root.join("lib", "**/")] # Configuração para uma aplicação apenas API
    config.api_only = true
  end
end
