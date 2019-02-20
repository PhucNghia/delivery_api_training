require "rails_helper"

RSpec.describe SessionsController, type: :controller do
  describe "POST #create" do
    let(:user) { FactoryBot.create :user, password: "123456", password_confirmation: "123456" }
    let(:params) { { username: user.username, password: "123456" } }

    describe "Login successful" do
      before { post :create, params: params }

      it "return user record with token" do
        user_record_name = JSON.parse(response.body)["user"]["username"]
        expect(user_record_name).to eq(user.username)
      end

      it "don't return password_digest" do
        result = JSON.parse(response.body)["user"]["password_digest"]
        expect(result).to be_nil
      end

      it "return valid token" do
        token = JSON.parse(response.body)["token"]
        user = User.find_by id: JsonWebToken.decode(token)["id"]
        expect(user).not_to be_nil
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end

    describe "Login failed" do
      before { post :create, params: { username: user.username } }

      it "return error message" do
        message = JSON.parse(response.body)["message"]
        expect(message).not_to be_empty
      end

      it "returns http unauthorized" do
        expect(response).to have_http_status(:unauthorized)
      end
    end
  end
end
