class Api::V1::WebhookController < ApplicationController
  DELAY_TIME_DEFAULT = 5.seconds

  before_action :check_callback_link?
  before_action :load_order
  before_action :load_status
  before_action :load_delay_time

  def create
    WebhookWorker.perform_in @delay_time, current_user.id, @order.id, @status.id
    render json: {
      order_id: @order.id,
      status_text: @status.text,
      perform_in: @delay_time
    }
  end

  private

  def check_callback_link?
    return true if current_user.callback_link?
    unprocessable_entity_error_response "You need to update the callback link"
  end

  def load_order
    @order = current_user.orders.find_by id: params[:order_id]
    return true if @order
    not_found_error_response I18n.t("orders.errors.not_found")
  end

  def load_status
    @status = Status.find_by id: params[:status_id]
    return true if @status
    not_found_error_response I18n.t("statuses.errors.not_found")
  end

  def load_delay_time
    @delay_time = params[:perform_in].present? ? params[:perform_in].to_i.seconds : DELAY_TIME_DEFAULT
  end
end
