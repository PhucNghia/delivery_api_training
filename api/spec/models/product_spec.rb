require "rails_helper"

RSpec.describe Product, type: :model do
  it{is_expected.to belong_to(:order)}

  it{is_expected.to validate_presence_of(:name)}
  it{is_expected.to validate_presence_of(:weight)}
  it{is_expected.to validate_presence_of(:quantity)}
end
