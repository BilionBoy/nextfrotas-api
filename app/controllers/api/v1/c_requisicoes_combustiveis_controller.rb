module Api::V1
   class CRequisicoesCombustiveisController < ApplicationController
    include JsonResponse
    include PagyPagination

    before_action :set_requisicao, only: %i[show update destroy]

    def index
      query = CRequisicaoCombustivel.ransack(params[:q])
      response = paginate(query.result.order(created_at: :desc), params[:per_page])
      render_success(data: response, message: "Requisições listadas com sucesso")
    end

    def show
      render_success(data: @requisicao, message: "Requisição encontrada com sucesso")
    end

    def create
      requisicao = CRequisicaoCombustivel.new(requisicao_params)
      requisicao.data_emissao ||= Time.current

      if requisicao.save
        render_success(data: requisicao, message: "Requisição criada com sucesso", status: :created)
      else
        render_error(message: "Erro ao criar requisição", errors: requisicao.errors.full_messages)
      end
    end

    def update
      if @requisicao.update(requisicao_params)
        render_success(data: @requisicao, message: "Requisição atualizada com sucesso")
      else
        render_error(message: "Erro ao atualizar requisição", errors: @requisicao.errors.full_messages)
      end
    end

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
        :tipo_limite,
        :valor_limite,
        :completar_tanque
      )
    end
   end
end
