require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:vertical).optional(true) }
  end

  describe "validations" do
    it_behaves_like "vertical and category name"
  end
end
