module Pagination
  extend ActiveSupport::Concern
  include Pagy::Backend

  def paginate_results(results, per_page: 1000)
    pagy, records = pagy(results, items: per_page)

    {
      status: "success",
      total:  pagy.count,
      data:   records,
      pagy:   pagy_metadata(pagy)
    }
  end

  def pagy_metadata(pagy)
    {
      page:  pagy.page,
      items: pagy.items,
      count: pagy.count,
      pages: pagy.pages
    }
  rescue NoMethodError => e
    { error: "Erro ao acessar dados de paginação: #{e.message}" }
  end
end
