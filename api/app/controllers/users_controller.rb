class UsersController < ApplicationController
  skip_before_action :authorized?

  def create
    @user = User.new user_params
    if @user.save
      render json: { user: @user, token: @user.token_generate },
        status: :created
    else
      unprocessable_entity_error_response @user.errors.full_messages
    end
  end

  private

  def user_params
    params.permit :username, :password, :password_confirmation
  end
end
