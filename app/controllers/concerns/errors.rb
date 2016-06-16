# Errors module to rescue from exception
#
module Concerns::Errors
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :render_bad_request
  end
end