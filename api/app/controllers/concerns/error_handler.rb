module ErrorHandler
  extend ActiveSupport::Concern

  class DecodeTokenError < StandardError; end

  included do
    %i(unauthorized unprocessable_entity not_found).each do |status|
      define_method "#{status}_error_response".to_sym do |message|
        render json: { message: message }, status: status
      end
    end
  end
end
