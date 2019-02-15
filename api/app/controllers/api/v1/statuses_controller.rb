class Api::V1::StatusesController < ApplicationController
  def index
    @statuses = Status.all
    render json: @statuses, status: :ok
  end
end
