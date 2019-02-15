class ApplicationController < ActionController::API
  before_action :authorized?
  include ErrorHandler
  attr_reader :current_user

  private

  def authorized?
    authorize_obj = AuthorizeApiRequest.new request.headers
    @current_user = authorize_obj.call
    return true if @current_user.present?
    unauthorized_error_response I18n.t("authenticate.errors.invalid_access")
  end
end
