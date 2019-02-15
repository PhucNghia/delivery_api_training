require "rails_helper"

RSpec.describe WebhookJob, type: :job do
  describe "#perform" do
    let(:user) { FactoryBot.create :user_with_orders }
    let(:callback_link) { user.callback_link }
    let(:order_id) { user.orders.first.id }
    let(:status_text) { create(:status).text }
    let(:webhook) { described_class.new }

    context "when exists callback link" do
      it "return a Net::HTTPSuccess" do
        expect(webhook.perform(callback_link, order_id, status_text)).to be_a(Net::HTTPSuccess)
      end
    end

    context "when callback link not found" do
      let(:callback_link) { "http://google.com/123" }

      it "return a Net::HTTPNotFound" do
        expect(webhook.perform(callback_link, order_id, status_text)).to be_a(Net::HTTPClientError)
      end
    end
  end
end
