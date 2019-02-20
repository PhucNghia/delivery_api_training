class UsersController < ApplicationController
  skip_before_action :authorized?, only: :create

  def create
    @user = User.new user_params
    if @user.save
      render json: {
          user: @user.as_json(only: [:id, :username, :callback_link]),
          token: @user.token_generate
        },
        status: :created
    else
      unprocessable_entity_error_response @user.errors.full_messages
    end
  end

  def update
    current_user.update user_update_params
    render json: current_user
  end

  private

  def user_params
    params.permit :username, :password, :password_confirmation
  end

  def user_update_params
    params.permit :callback_link
  end
end
