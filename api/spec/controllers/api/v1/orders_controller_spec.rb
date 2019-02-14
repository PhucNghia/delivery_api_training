require "rails_helper"

RSpec.describe Api::V1::OrdersController, type: :controller do
  let(:user) { FactoryBot.create :user_with_orders, orders_count: 5 }
  let(:headers) { { "Authorization" => user.token_generate } }
  let(:invalid_headers) { { "Authorization" => "" } }

  context "when haven't token or invalid token" do
    before { request.headers.merge! invalid_headers }
    before { get :index }

    it "return error message" do
      message = JSON.parse(response.body)["message"]
      expect(message).not_to be_empty
    end

    it "returns http unauthorized" do
      expect(response).to have_http_status(:unauthorized)
    end
  end

  describe "GET #index" do
    context "when have token" do
      before { request.headers.merge! headers }
      before { get :index }

      it "return all orders of user" do
        orders = JSON.parse(response.body)
        expect(orders.all?{|order| order["user_id"] == user.id}).to be_truthy
        expect(orders.count).to eq(5)
      end
    end
  end

  describe "GET #show" do
    let(:order) { user.orders.first }
    let(:params) { { id: order.id } }
    before { request.headers.merge! headers }
    before { get :show, params: params }

    context "when exists order" do
      it "return order" do
        order_result = JSON.parse(response.body)
        expect(order_result["id"]).to eq(order.id)
      end
    end

    context "when not found order" do
      let(:params) { { id: 100 } }

      it "return error message" do
        message = JSON.parse(response.body)["message"]
        expect(message).not_to be_empty
      end

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when user don't have permission access to order" do
      let(:other_user) { FactoryBot.create :user }
      let(:headers) { { "Authorization" => other_user.token_generate } }
      before { request.headers.merge! headers }

      it "return error message" do
        message = JSON.parse(response.body)["message"]
        expect(message).not_to be_empty
      end

      it "returns http unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end

  describe "POST #create" do
    let(:params) do
      {
        bill_address_attributes: attributes_for(:bill_address),
        ship_address_attributes: attributes_for(:ship_address),
        status_id: create(:status).id,
        amount: 10000,
      }
    end
    let(:invalid_params) { {} }
    before { request.headers.merge! headers }

    context "when valid params" do
      it "create the order" do
        expect { post :create, params: params }.to change { Order.count }.by(1)
      end
    end

    context "when invalid params" do
      before { post :create, params: invalid_params }

      it "return error message" do
        message = JSON.parse(response.body)["message"]
        expect(message).not_to be_empty
      end

      it "returns http unprocessable entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PUT #update" do
    let(:order) { user.orders.first }
    let(:params) do
      {
        id: order.id,
        bill_address_attributes: attributes_for(:bill_address),
        ship_address_attributes: attributes_for(:ship_address),
        status_id: create(:status).id,
        amount: 1,
      }
    end
    let(:invalid_params) { { id: order.id, amount: "" } }
    before { request.headers.merge! headers }

    context "when valid params" do
      before { put :update, params: params }

      it "update the order" do
        order_result = JSON.parse(response.body)
        expect(order_result["id"]).to eq(order.id)
        expect(order_result["amount"]).to eq(1)
      end
    end

    context "when invalid params" do
      before { put :update, params: invalid_params }

      it "return error message" do
        message = JSON.parse(response.body)["message"]
        expect(message).not_to be_empty
      end

      it "returns http unprocessable entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE #destroy" do
    let(:order) { user.orders.first }
    let(:params) { { id: order.id } }
    before { request.headers.merge! headers }
    before { delete :destroy, params: params }

    it "returns http ok" do
      expect(response).to have_http_status(:ok)
    end
  end
end
