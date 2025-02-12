module JsonResponse
  extend ActiveSupport::Concern
  def render_json (status:, data:, total: nil, status_code: 200)

    response = { status: status, data: data }
    response[:total] = total if total

    render json: response, status: status_code
  end
end
