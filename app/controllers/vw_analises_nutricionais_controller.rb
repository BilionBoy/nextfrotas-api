class VwAnalisesNutricionaisController < ApplicationController
  include JsonResponse

  def index
    query = VwAnaliseNutricional.ransack(params[:q])
    pagy, paged = pagy(query.result.order(:id), limit: params[:per_page] || 1000)
    
    render json: {
      pagy: {
        current_page: pagy.page,
        total_pages:  pagy.pages,
        total_count:  pagy.count,
        per_page:     pagy.limit,
      },
      items: paged,
    }
  end
end
