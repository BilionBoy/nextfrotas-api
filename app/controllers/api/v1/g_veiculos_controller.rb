# frozen_string_literal: true

module Api
  module V1
    class GVeiculosController < ApplicationController
      include JsonResponse
      include PagyPagination
      before_action :set_veiculo, only: %i[show update destroy]

      # GET /api/v1/veiculos
      def index
        query = GVeiculo.ransack(params[:q])
        pagy_data = paginate(query.result.order(:id), params[:per_page])

        render_success(
          message: "Veículos listados com sucesso",
          data: {
            pagy: pagy_data[:pagy],
            items: ActiveModelSerializers::SerializableResource.new(
              pagy_data[:items],
              each_serializer: GVeiculoSerializer
            )
          }
        )
      end

      # GET /api/v1/veiculos/:id
      def show
        render_success(
          data: GVeiculoSerializer.new(@veiculo),
          message: "Veículo encontrado com sucesso"
        )
      end

      # POST /api/v1/veiculos
      def create
        veiculo = GVeiculo.new(veiculo_params)

        if veiculo.save
          render_success(
            data: GVeiculoSerializer.new(veiculo),
            message: "Veículo criado com sucesso"
          )
        else
          render_error(
            message: "Erro ao criar veículo",
            errors: veiculo.errors.full_messages
          )
        end
      end

      # PATCH/PUT /api/v1/veiculos/:id
      def update
        if @veiculo.update(veiculo_params)
          render_success(
            data: GVeiculoSerializer.new(@veiculo),
            message: "Veículo atualizado com sucesso"
          )
        else
          render_error(
            message: "Erro ao atualizar veículo",
            errors: @veiculo.errors.full_messages
          )
        end
      end

      # DELETE /api/v1/veiculos/:id
      def destroy
        if @veiculo.destroy
          render_success(message: "Veículo excluído com sucesso")
        else
          render_error(message: "Erro ao excluir veículo")
        end
      end

      private

      def set_veiculo
        @veiculo = GVeiculo.find_by(id: params[:id])
        render_error(message: "Veículo não encontrado", status: :not_found) unless @veiculo
      end
      def veiculo_params
        params.require(:g_veiculo).permit(:placa, :chassi, :renavam, :modelo, :ano, :marca, :cor, :km_atual, :a_status_id, :g_tipo_veiculo_id, :a_unidade_id, :g_centro_custo_id)
      end
    end
  end
end
