require 'rails_helper'

RSpec.describe Vertical, type: :model do
  describe "validations" do
    it_behaves_like "vertical and category name"
  end
end
