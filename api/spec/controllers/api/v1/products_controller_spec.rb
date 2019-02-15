require "rails_helper"

RSpec.describe Api::V1::ProductsController, type: :controller do
  let(:user) { FactoryBot.create :user_with_orders, orders_count: 5 }
  let(:headers) { { "Authorization" => user.token_generate } }
  let(:order) { user.orders.first }
  let(:product) { order.products.first }

  context "when order not exists" do
    before { request.headers.merge! headers }
    before { get :index, params: { id: product.id, order_id: 100 } }

    it "return error message" do
      message = JSON.parse(response.body)["message"]
      expect(message).not_to be_empty
    end

    it "returns http not found" do
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET #index" do
    context "when exists order" do
      before { request.headers.merge! headers }
      before { get :index, params: { id: product.id, order_id: order.id } }

      it "return all products of order" do
        products = JSON.parse(response.body)
        expect(products.all? { |product| product["order_id"] == order.id }).to be_truthy
      end
    end
  end

  describe "POST #create" do
    let(:params) do
      {
        order_id: order.id,
        products_attributes: [attributes_for(:product)],
      }
    end
    let(:invalid_params) { { id: product.id, order_id: order.id, products_attributes: [name: ""] } }
    before { request.headers.merge! headers }

    context "when valid params" do
      it "create the order" do
        expect { post :create, params: params }.to change { order.products.count }.by(1)
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
    let(:params) do
      {
        id: product.id,
        order_id: order.id,
        name: "product_test",
        weight: product.weight,
        quantity: product.quantity,
      }
    end
    let(:invalid_params) { { id: product.id, order_id: order.id, name: "" } }
    before { request.headers.merge! headers }

    context "when product not found" do
      before { put :update, params: { id: 1000, order_id: order.id } }

      it "return error message" do
        message = JSON.parse(response.body)["message"]
        expect(message).not_to be_empty
      end

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when valid params" do
      before { put :update, params: params }

      it "update the product" do
        product_result = JSON.parse(response.body)
        expect(product_result["id"]).to eq(product.id)
        expect(product_result["name"]).to eq("product_test")
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
    let(:order_one) { create :order, products_count: 1, user_id: user.id }
    let(:order_five) { create :order, products_count: 5, user_id: user.id }
    let(:product_one) { order_one.products.first }
    let(:product_five) { order_five.products.first }

    context "when order has 1 product" do
      let(:params) { { order_id: order_one.id, id: product_one.id } }
      before { request.headers.merge! headers }
      before { delete :destroy, params: params }

      it "return error message" do
        message = JSON.parse(response.body)["message"]
        expect(message).not_to be_empty
      end

      it "returns http unprocessable entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end

    context "when order has more than 1 product" do
      let(:params) { { order_id: order_five.id, id: product_five.id } }
      before { request.headers.merge! headers }
      before { delete :destroy, params: params }

      it "returns http ok" do
        expect(response).to have_http_status(:ok)
      end
    end
  end
end
