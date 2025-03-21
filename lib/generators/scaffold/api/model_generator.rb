# frozen_string_literal: true

require "rails/generators"

module Scaffold
  module Api
    class ModelGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)

      # Método para gerar o model
      def generate_model
        template "model.rb.tt", "app/models/#{file_name}.rb"
      end
    end
  end
end
