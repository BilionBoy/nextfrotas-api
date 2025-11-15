class ApplicationController < ActionController::API
  include Pagy::Backend
  include JsonResponse
  include AuthorizeRequest

  private

  def current_user
    @current_user
  end
end
