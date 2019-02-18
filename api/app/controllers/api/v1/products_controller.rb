class Api::V1::ProductsController < ApplicationController
  before_action :load_order
  before_action :load_product, only: %i(update destroy)

  def index
    render json: @order.products, status: :ok
  end

  def create
    if @order.update order_params
      render json: @order.products, status: :created
    else
      unprocessable_entity_error_response @order.errors.full_messages
    end
  end

  def update
    if @product.update product_params
      render json: @product, status: :created
    else
      unprocessable_entity_error_response @product.errors.full_messages
    end
  end

  def destroy
    if @product.destroy
      head :ok
    else
      unprocessable_entity_error_response @product.errors.full_messages
    end
  end

  private

  def order_params
    params.permit products_attributes: [:id, :name, :weight, :quantity, :_destroy]
  end

  def product_params
    params.permit :name, :weight, :quatity
  end

  def load_order
    @order = current_user.orders.find_by id: params[:order_id]
    return if @order
    not_found_error_response I18n.t("orders.errors.not_found")
  end

  def load_product
    @product = @order.products.find_by id: params[:id]
    return if @product
    not_found_error_response I18n.t("products.errors.not_found")
  end
end
