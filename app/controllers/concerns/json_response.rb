module JsonResponse
  extend ActiveSupport::Concern

  def render_success(data:, message:, status: :ok)
    render json: {
      status:  "success",
      message:  message,
      data:     data
    }, status:  status
  end
end
