require "rails_helper"

RSpec.describe UsersController, type: :controller do

  describe "POST #create" do
    let(:valid_params) { { username: "username", password: "123123", password_confirmation: "123123" } }
    let(:invalid_params) { { username: "username" } }

    context "when valid params" do
      before { post :create, params: valid_params }

      it "return user record with token" do
        user_record_name = JSON.parse(response.body)["user"]["username"]
        expect(user_record_name).to eq("username")
      end

      it "return valid token" do
        token = JSON.parse(response.body)["token"]
        expect(token).not_to be_nil
        expect(JsonWebToken.decode(token)["id"]).not_to be_nil
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
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
end
