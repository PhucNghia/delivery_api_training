require "rails_helper"

RSpec.describe AuthorizeApiRequest do
  describe "#call" do
    let(:user) { FactoryBot.create :user }
    let(:headers) { { "authorization" => user.token_generate } }
    let(:expired_token) { JsonWebToken.encode({ id: user.id }, Time.now.to_i - 10) }
    let(:headers_with_expired_token) { { "authorization" => expired_token } }
    context "when valid headers" do
      it "return user object" do
        result_user = described_class.new(headers).call
        expect(result_user.id).to eq(user.id)
      end
    end

    context "when headers with expired token" do
      it "return DecodeTokenError" do
        expect { described_class.new(headers_with_expired_token).call }.to raise_error(ErrorHandler::DecodeTokenError)
      end
    end

    context "when invalid headers" do
      it "return nil" do
        result = described_class.new({}).call
        expect(result).to be_nil
      end
    end
  end
end
