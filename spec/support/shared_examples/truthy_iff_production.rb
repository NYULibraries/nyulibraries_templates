RSpec.shared_examples "truthy_iff_production" do
  context "when Rails.env is production" do
    before { allow(Rails.env).to receive(:production?).and_return true }

    it { is_expected.to be_truthy }
  end

  context "when Rails.env is not production" do
    before { allow(Rails.env).to receive(:production?).and_return false }

    it { is_expected.to be_falsy }
  end
end
