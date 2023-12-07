RSpec.shared_examples "vertical and category name" do
  describe "validate name uniqueness" do
    subject { build(described_class_name, name: 'Test') }

    let(:described_class_name) { described_class.name.underscore.to_sym }

    context "when name is not taken" do
      before do
        create(:category, name: 'TEST')
      end

      it "should be valid" do
        expect(subject.valid?(:name)).to be_truthy
      end
    end

    context "when name already taken by other category" do
      before { create(:category, name: 'Test') }

      it "should be invalid" do
        expect(subject.valid?(:name)).to be_falsy
      end

      it "should have name error message" do
        subject.valid?
        expect(subject.errors[:name]).to include('is already taken.')
      end
    end

    context "when name already taken by vertical" do
      before { create(:vertical, name: 'Test') }

      it "should be invalid" do
        expect(subject.valid?(:name)).to be_falsy
      end

      it "should have name error message" do
        subject.valid?(:name)
        expect(subject.errors[:name]).to include('is already taken.')
      end
    end
  end
end
