# frozen_string_literal: true

module Api
  module V1
    class CRequisicoesCombustiveisController < ApplicationController
      include JsonResponse
      include PagyPagination

     before_action :require_gestor!, except: %i[find_by_code validar_voucher]
     before_action :set_requisicao,  only:   %i[show update destroy validar_voucher]

      # ==========================================================
      # GET /api/v1/requisicoes/find_by_code?codigo=XXXX
      # ==========================================================
      def find_by_code
        req = CRequisicaoCombustivel.find_by(voucher_codigo: params[:codigo])

        return render_error(message: "Voucher não encontrado") unless req

        render_success(
          message: "Voucher encontrado",
          data: CRequisicaoCombustivelSerializer.new(req)
        )
      end

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
          message: "Requisição encontrada com sucesso",
          data: CRequisicaoCombustivelSerializer.new(@requisicao)
        )
      end


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
      # POST /api/v1/requisicoes
      # ==========================================================
      def create
        requisicao = CRequisicaoCombustivel.new(requisicao_params)
        requisicao.data_emissao ||= Time.current
        requisicao.voucher_status ||= "pendente"

        if requisicao.save
          render_success(
            message: "Requisição criada com sucesso",
            data: CRequisicaoCombustivelSerializer.new(requisicao.reload)
          )
        else
          render_error(
            message: "Erro ao criar requisição",
            errors: requisicao.errors.full_messages
          )
        end
      end

      # ==========================================================
      # PATCH /api/v1/requisicoes/:id/validar_voucher
      # ==========================================================
      def validar_voucher
        quantidade = params[:quantidade_litros].to_f
        total = params[:valor_total].to_f

        if quantidade <= 0 || total <= 0
          return render_error(message: "Quantidade e valor total devem ser maiores que zero.")
        end

        preco_unitario = total / quantidade

        if @requisicao.update(
          quantidade_litros: quantidade,
          valor_total: total,
          preco_unitario: preco_unitario,
          voucher_status: "validado",
          voucher_validado_em: Time.current,
          voucher_validado_por_id: current_user.id
        )

          render_success(
            message: "Voucher validado com sucesso",
            data: CRequisicaoCombustivelSerializer.new(@requisicao)
          )
        else
          render_error(
            message: "Erro ao validar voucher",
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
        render_error(message: "Requisição não encontrada") unless @requisicao
      end

      def requisicao_params
        permitted_attributes =
          CRequisicaoCombustivel.column_names.reject do |c|
            [ "deleted_at", "created_by", "updated_by" ].include?(c)
          end

        params.require(:c_requisicao_combustivel).permit(permitted_attributes.map(&:to_sym))
      end
    end
  end
end
