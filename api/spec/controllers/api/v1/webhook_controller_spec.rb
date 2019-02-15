require "rails_helper"

RSpec.describe Api::V1::WebhookController, type: :controller do
  DELAY_TIME = 5.seconds

  describe "POST #create" do
    let(:user) { create :user_with_orders }
    let(:user_no_callback_link) { create :user_no_callback_link }
    let(:order) { user.orders.first }
    let(:status) { create :status }
    let(:perform_in) { DELAY_TIME }
    let(:headers) { { "Authorization" => user.token_generate } }
    let(:headers_user_no_callback_link) { { "Authorization" => user_no_callback_link.token_generate } }

    context "when user don't have callback link" do
      let(:params) do
        {
          order_id: order.id,
          status_id: status.id,
          perform_in: perform_in,
        }
      end

      before { request.headers.merge! headers_user_no_callback_link }
      before { post :create, params: params }

      it "return error message" do
        message = JSON.parse(response.body)["message"]
        expect(message).to include("You need to update the callback link")
      end

      it "returns http unprocessable_entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when order not found" do
      let(:params) do
        {
          order_id: 1000,
          status_id: status.id,
          perform_in: perform_in,
        }
      end

      before { request.headers.merge! headers }
      before { post :create, params: params }

      it "return error message" do
        message = JSON.parse(response.body)["message"]
        expect(message).not_to be_empty
      end

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when status not found" do
      let(:params) do
        {
          order_id: order.id,
          status_id: 1000,
          perform_in: perform_in,
        }
      end

      before { request.headers.merge! headers }
      before { post :create, params: params }

      it "return error message" do
        message = JSON.parse(response.body)["message"]
        expect(message).not_to be_empty
      end

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when exists order and status" do
      let(:params) do
        {
          order_id: order.id,
          status_id: status.id,
          perform_in: perform_in,
        }
      end

      before { request.headers.merge! headers }
      before { post :create, params: params }

      it "update order status" do
        order = Order.find_by id: params[:order_id]
        expect(order.status.id).to eq(status.id)
      end

      it "return order_id, status_text, perform_in" do
        result = JSON.parse(response.body)
        expect(result["order_id"]).to eq(order.id)
        expect(result["status_text"]).to eq(status.text)
        expect(result["perform_in"]).to eq(perform_in)
      end
    end

    context "when params perform_in not exists" do
      let(:params) do
        {
          order_id: order.id,
          status_id: status.id,
        }
      end

      before { request.headers.merge! headers }
      before { post :create, params: params }

      it "set default delay time to perform_in" do
        result = JSON.parse(response.body)
        expect(result["perform_in"]).to eq(perform_in)
      end
    end
  end
end
