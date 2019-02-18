class Api::V1::OrdersController < ApplicationController
  before_action :load_order, only: %i(show update destroy)
  before_action :valid_access?, only: %i(show update destroy)

  def index
    render json: current_user.orders, status: :ok
  end

  def show
    render json: @order, status: :ok
  end

  def create
    @order = current_user.orders.new order_params
    if @order.save
      render json: @order, status: :created
    else
      unprocessable_entity_error_response @order.errors.full_messages
    end
  end

  def update
    if @order.update order_params
      render json: @order, status: :created
    else
      unprocessable_entity_error_response @order.errors.full_messages
    end
  end

  def destroy
    @order.destroy
    head :ok
  end

  private

  def order_params
    params.permit :amount, :status_id, bill_address_attributes: [:name, :tel, :address],
      ship_address_attributes: [:name, :tel, :address], products_attributes: [:id, :name, :weight, :quantity, :_destroy]
  end

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order
    not_found_error_response I18n.t("orders.errors.not_found")
  end

  def valid_access?
    return if @order.owner? current_user
    unauthorized_error_response I18n.t("authenticate.errors.invalid_access")
  end
end
