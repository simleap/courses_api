require 'rails_helper'

RSpec.describe Course, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:category).optional(true) }
  end
end
