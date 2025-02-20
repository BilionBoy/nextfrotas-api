module V1
  class VwEscolasMatriculasController < ApplicationController
    include JsonResponse
    include PagyPagination

    def index
      query = VwEscolaMatricula.ransack(params[:q])
      response = paginate(query.result, params[:per_page])

      render_success(data: response, message: "Vw escolas matriculas listados com sucesso")
    end
  end
end
