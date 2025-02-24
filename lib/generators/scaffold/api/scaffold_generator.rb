# frozen_string_literal: true

require "rails/generators"

module Scaffold
  module Api
    class ScaffoldGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)

      # Método responsável por gerar os componentes
      def generate_components
        generate_controller
      end

      private

      # Método para gerar o controller
      def generate_controller
        invoke "scaffold:api:controller", [name] + args
      end
    end
  end
end
