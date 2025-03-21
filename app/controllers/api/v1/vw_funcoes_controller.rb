module Api::V1
    class VwFuncoesController < ApplicationController
      include JsonResponse
      include PagyPagination

      def index
        query = VwFuncao.ransack(params[:q])
        response = paginate(query.result, params[:per_page])
        render_success(data: response, message: "Valores não encontrados")
      end
    end
end
