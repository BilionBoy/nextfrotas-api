# frozen_string_literal: true
require "rails/generators"

module Scaffold
  module Api
    class ControllerGenerator < Rails::Generators::NamedBase
      source_root File.expand_path("templates", __dir__)

      argument :attributes, type: :array, default: []

      # Gera o arquivo do controller com base no nome e atributos fornecidos
      def create_controller_file
        namespace = "V1"
        plural_file_name = file_name.pluralize
        file_path = controller_file_path(namespace, plural_file_name)

        @controller_class_name = plural_file_name.camelize
        @assign_attributes = formatted_attributes

        template "controller.rb.tt", file_path
      end

      private

      # Retorna o caminho correto para salvar o arquivo do controller
      def controller_file_path(namespace, plural_file_name)
        File.join("app/controllers", namespace.underscore, "#{plural_file_name}_controller.rb")
      end

      # Formata os atributos fornecidos, organizando-os como nome e tipo
      def formatted_attributes
        attributes.map { |attr| { name: attr.name, type: attr.type } }
      end
    end
  end
end
