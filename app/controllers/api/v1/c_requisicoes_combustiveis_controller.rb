# frozen_string_literal: true

module Api
  module V1
    class CRequisicoesCombustiveisController < ApplicationController
      include JsonResponse
      include PagyPagination

      before_action :set_requisicao, only: %i[show update destroy]

      # ==========================================================
      # GET /api/v1/requisicoes
      # ==========================================================
      def index
        query = CRequisicaoCombustivel.ransack(params[:q])
        pagy_data = paginate(
          query.result
               .includes(:posto, :veiculo, :condutor, :centro_custo, :tipo_combustivel, :status)
               .order(created_at: :desc),
          params[:per_page]
        )

        render_success(
          message: "Requisições listadas com sucesso",
          data: {
            pagy: pagy_data[:pagy],
            items: ActiveModelSerializers::SerializableResource.new(
              pagy_data[:items],
              each_serializer: CRequisicaoCombustivelSerializer
            )
          }
        )
      end

      # ==========================================================
      # GET /api/v1/requisicoes/:id
      # ==========================================================
      def show
        render_success(
          data: CRequisicaoCombustivelSerializer.new(@requisicao),
          message: "Requisição encontrada com sucesso"
        )
      end

      # ==========================================================
      # POST /api/v1/requisicoes
      # ==========================================================
      def create
        requisicao = CRequisicaoCombustivel.new(requisicao_params)
        requisicao.data_emissao ||= Time.current
        requisicao.voucher_status ||= "pendente" # callbacks cuidam do código e validade

        if requisicao.save
          render_success(
            message: "Requisição criada com sucesso",
            data: CRequisicaoCombustivelSerializer.new(
              requisicao.reload,
              include: %i[posto veiculo tipo_combustivel status]
            )
          )
        else
          render_error(
            message: "Erro ao criar requisição",
            errors: requisicao.errors.full_messages
          )
        end
      end

      # ==========================================================
      # PATCH/PUT /api/v1/requisicoes/:id
      # ==========================================================
      def update
        if @requisicao.update(requisicao_params)
          render_success(
            data: CRequisicaoCombustivelSerializer.new(@requisicao),
            message: "Requisição atualizada com sucesso"
          )
        else
          render_error(
            message: "Erro ao atualizar requisição",
            errors: @requisicao.errors.full_messages
          )
        end
      end

      # ==========================================================
      # DELETE /api/v1/requisicoes/:id
      # ==========================================================
      def destroy
        if @requisicao.destroy
          render_success(message: "Requisição excluída com sucesso")
        else
          render_error(message: "Erro ao excluir requisição")
        end
      end

      private

      def set_requisicao
        @requisicao = CRequisicaoCombustivel.find_by(id: params[:id])
        render_error(message: "Requisição não encontrada", status: :not_found) unless @requisicao
      end

      def requisicao_params
        params.require(:c_requisicao_combustivel).permit(
          :g_veiculo_id,
          :c_posto_id,
          :c_tipo_combustivel_id,
          :g_condutor_id,
          :g_centro_custo_id,
          :km_ultimo,
          :km_atual,
          :motivo,
          :destino,
          :itinerario,
          :preco_unitario,
          :quantidade_litros,
          :valor_total,
          :completar_tanque
        )
      end
    end
  end
end
