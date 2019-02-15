class WebhookWorker
  include Sidekiq::Worker

  def perform(user_id, order_id, status_id)
    user = User.find_by id: user_id
    order = Order.find_by id: order_id
    status = Status.find_by id: status_id
    if order.update status: status
      job = WebhookJob.new
      job.perform user.callback_link, order.id, status.text
    end
  end
end
