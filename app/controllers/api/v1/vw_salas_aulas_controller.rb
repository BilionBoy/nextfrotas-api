module Api::V1
    class VwSalasAulasController < ApplicationController
      include JsonResponse
      include PagyPagination

      def index
        query = VwSalaAula.ransack(params[:q])
        response = paginate(query.result.order(:id), params[:per_page])
        render_success(data: response, message: "Vw sala aulas listados com sucesso")
      end
    end
end
