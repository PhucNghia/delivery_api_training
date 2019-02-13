require "rails_helper"

RSpec.describe Status, type: :model do
  it{is_expected.to have_many(:orders)}

  it{is_expected.to validate_presence_of(:text)}
  it{is_expected.to validate_uniqueness_of(:text).ignoring_case_sensitivity}
end
