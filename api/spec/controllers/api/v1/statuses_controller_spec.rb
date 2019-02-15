require 'rails_helper'

RSpec.describe Api::V1::StatusesController, type: :controller do
  let(:user) { FactoryBot.create :user_with_orders, orders_count: 5 }
  let(:headers) { { "Authorization" => user.token_generate } }
  let(:statuses) { create_list :status, 5}

  describe "GET #index" do
    before { request.headers.merge! headers }
    before { get :index }

    it "returns all status" do
      statuses_result = JSON.parse(response.body)
      expect(statuses_result.count).to eq(5)
    end

    it "returns http ok" do
      expect(response).to have_http_status(:ok)
    end
  end

end
