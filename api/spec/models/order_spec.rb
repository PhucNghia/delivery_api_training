require "rails_helper"

RSpec.describe Order, type: :model do
  it{is_expected.to have_many(:products).dependent(:destroy)}
  it{is_expected.to belong_to(:status)}
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
  it{is_expected.to accept_nested_attributes_for(:products)}
  it{is_expected.to accept_nested_attributes_for(:bill_address)}
  it{is_expected.to accept_nested_attributes_for(:ship_address)}

  it{is_expected.to validate_presence_of(:amount)}
end
