module Api
  module V1
    class CCombustiveisController < ApplicationController
      include JsonResponse
      include PagyPagination

      before_action :set_combustivel, only: [ :show, :update, :destroy ]

      # GET /api/v1/combustiveis
      def index
        query = CCombustivel.ransack(params[:q])
        response = paginate(query.result.order(:id), params[:per_page])
        render_success(data: response, message: "Combustíveis listados com sucesso")
      end

      # GET /api/v1/combustiveis/:id
      def show
        render_success(data: @combustivel, message: "Combustível encontrado com sucesso")
      end

      # POST /api/v1/combustiveis
      def create
        combustivel = CCombustivel.new(combustivel_params)

        if combustivel.save
          render_success(data: combustivel, message: "Combustível criado com sucesso", status: :created)
        else
          render_error(message: "Erro ao criar combustível", errors: combustivel.errors.full_messages, status: :unprocessable_entity)
        end
      end

      # PUT/PATCH /api/v1/combustiveis/:id
      def update
        if @combustivel.update(combustivel_params)
          render_success(data: @combustivel, message: "Combustível atualizado com sucesso")
        else
          render_error(message: "Erro ao atualizar combustível", errors: @combustivel.errors.full_messages, status: :unprocessable_entity)
        end
      end

      # DELETE /api/v1/combustiveis/:id
      def destroy
        if @combustivel.destroy
          render_success(message: "Combustível excluído com sucesso")
        else
          render_error(message: "Erro ao excluir combustível", errors: @combustivel.errors.full_messages, status: :unprocessable_entity)
        end
      end

      private

      def set_combustivel
        @combustivel = CCombustivel.find_by(id: params[:id])
        render_error(message: "Combustível não encontrado", status: :not_found) unless @combustivel
      end

     def combustivel_params
       params.require(:c_combustivel).permit(
         :c_tipo_combustivel_id,
         :preco,
         :validade,
         :descricao,
         :tipo,
         :ativo
       )
     end
    end
  end
end
