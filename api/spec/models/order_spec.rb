require "rails_helper"

RSpec.describe Order, type: :model do
  it { is_expected.to have_many(:products).dependent(:destroy) }
  it { is_expected.to belong_to(:status) }
  it { is_expected.to belong_to(:user) }
  it do
    is_expected.to belong_to(:bill_address)
      .dependent(:destroy)
      .with_foreign_key(:bill_address_id)
      .class_name(Address.name)
  end
  it do
    is_expected.to belong_to(:ship_address)
      .dependent(:destroy)
      .with_foreign_key(:ship_address_id)
      .class_name(Address.name)
  end
  it { is_expected.to accept_nested_attributes_for(:products).allow_destroy(true) }
  it { is_expected.to accept_nested_attributes_for(:bill_address) }
  it { is_expected.to accept_nested_attributes_for(:ship_address) }

  it { is_expected.to validate_presence_of(:amount) }

  describe "Custom validate" do
    let(:user) { create :user }
    let(:invalid_params) do
      {
        products_attributes: [],
        bill_address_attributes: attributes_for(:bill_address),
        ship_address_attributes: attributes_for(:ship_address),
        status_id: create(:status).id,
        amount: 10000,
      }
    end

    context "when haven't products" do
      before { @order = user.orders.new invalid_params }
      it "return error validate" do
        @order.valid?
        expect(@order.errors.full_messages).to include("Order must have at least one product")
      end
    end
  end
end
