# Error Handlers
#
module Concerns::ErrorHandlers
  extend ActiveSupport::Concern

  def render_bad_request(e)
    render json: { errors: e.message }, status: :bad_request
  end
end