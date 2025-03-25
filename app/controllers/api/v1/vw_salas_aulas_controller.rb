module Api::V1
  class VwSalasAulasController < ApplicationController
    include JsonResponse
    include PagyPagination

    def index
      response = paginate(VwSalaAula.ransack(params[:q]).result.order(:id), params[:per_page])
      render_success(data: response.slice(:pagy, :items).merge(items: response[:items].as_json(only: [ :escola, :cre, :capacidade, :id ])), message: "Vw sala aulas listados com sucesso")
    end
  end
end
