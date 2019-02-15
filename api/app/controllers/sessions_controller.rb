class SessionsController < ApplicationController
  before_action :load_user, only: :create

  def create
    if @user.authenticate(params[:password])
      render json: { token: @user.token_generate }, status: :ok
    else
      unauthorized_error_response I18n.t("authenticate.errors.username_or_password_incorrect")
    end
  end

  private

  def load_user
    @user = User.find_by username: params[:username]
    unauthorized_error_response I18n.t("authentice.errors.username_or_password_incorrect") unless @user
  end
end
