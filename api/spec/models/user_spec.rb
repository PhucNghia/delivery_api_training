require "rails_helper"

RSpec.describe User, type: :model do
  it{is_expected.to have_secure_password}
  it{is_expected.to have_many(:orders).dependent(:destroy)}

  it{is_expected.to validate_presence_of(:username)}
  it{is_expected.to validate_presence_of(:password).on(:create)}
  it{is_expected.to validate_uniqueness_of(:username).ignoring_case_sensitivity}
end
