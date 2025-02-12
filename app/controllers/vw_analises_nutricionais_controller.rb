class VwAnalisesNutricionaisController < ApplicationController
  include JsonResponse
  include Pagination

  def index
    query = VwAnaliseNutricional.ransack(params[:q])
    pagy, paged = pagy(query.result, limit: params[:per_page] || 10)
    render json: {
      pagy:  {
        current_page: pagy.page,
        total_pages: pagy.pages,
        total_count: pagy.count,
        per_page: pagy.limit
      },
      items: paged
    }
  end
end
