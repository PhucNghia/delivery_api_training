require "rails_helper"

RSpec.describe Address, type: :model do
  it{is_expected.to validate_presence_of(:name)}
  it{is_expected.to validate_presence_of(:address)}
  it{is_expected.to validate_presence_of(:tel)}
end
