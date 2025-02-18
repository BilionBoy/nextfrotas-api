require "rails/generators/rails/scaffold_controller/scaffold_controller_generator"

module Scaffold
  module Api
    class ControllerGenerator < Rails::Generators::ScaffoldControllerGenerator
      source_root File.expand_path("templates", __dir__)

      def create_controller_files
        template "controller.rb.tt", File.join("app/controllers/v1", class_path, "#{controller_file_name}_controller.rb")
      end
    end
  end
end
