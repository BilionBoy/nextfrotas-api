# frozen_string_literal: true

require "rails/generators"

module Scaffold
  module Api
    # Gerador de Controllers para API
    class ControllerGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)

      def create_controller_file
        template "controller.rb.tt", controller_file_path
      end

      private

      def controller_file_path
        File.join("app/controllers/api/v1", "#{file_name.pluralize}_controller.rb")
      end
    end
  end
end
