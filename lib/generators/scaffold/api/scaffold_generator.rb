# frozen_string_literal: true

require "rails/generators"

module Scaffold
  module Api
    class ScaffoldGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)

      # Método responsável por gerar os componentes
      def generate_components
        generate_controller
        generate_model
        generate_serializer
      end

      private

      # Método para gerar o controller
      def generate_controller
        invoke "scaffold:api:controller", [ name ] + args
      end

      # Método para gerar a modle
      def generate_model
        invoke "scaffold:api:model", "app/models/#{file_name}.rb"
      end

      # Método para gerar o serializer
      def generate_serializer
        invoke "scaffold:api:serializer", "app/serializers/#{file_name}_serializer.rb"
      end
    end
  end
end
