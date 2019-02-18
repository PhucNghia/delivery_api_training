require "net/http"

class WebhookJob < ApplicationJob
  queue_as :default

  def perform(callback_link, order_id, status_text)
    uri = URI.parse(callback_link)
    params = { order_id: order_id, status_text: status_text }
    http = Net::HTTP.new(uri.host)
    request = Net::HTTP::Post.new(uri.path)
    request.set_form_data(params)
    res = http.request(request)
  end
end
