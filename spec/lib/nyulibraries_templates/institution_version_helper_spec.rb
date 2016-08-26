require 'spec_helper'

describe NyulibrariesTemplates::InstitutionVersionHelper do
  let(:helper){ Class.new { extend NyulibrariesTemplates::InstitutionVersionHelper } }

  describe "institutions_included?" do
    subject{ helper.institutions_included? }

    context "with institutions_defined? true" do
      before { allow(helper).to receive(:institutions_defined?).and_return true }

      context "with institution_version_required? true" do
        before { allow(helper).to receive(:institution_version_required?).and_return true }

        it { is_expected.to be_truthy }
      end

      context "with institution_version_required? false" do
        before { allow(helper).to receive(:institution_version_required?).and_return false }

        it { is_expected.to be_falsy }
      end
    end

    context "with institutions_defined? false" do
      before { allow(helper).to receive(:institutions_defined?).and_return false }

      it { is_expected.to be_falsy }
    end
  end

  describe "institutions_defined?" do
    subject{ helper.institutions_defined? }

    context "without NyulibrariesInstitutions" do
      it { is_expected.to be_falsy }
    end

    context "with NyulibrariesInstitutions defined" do
      let(:fake_institutions){ Class.new }
      before { stub_const("NyulibrariesInstitutions", fake_institutions) }

      it { is_expected.to be_truthy }
    end
  end

  describe "institution_version_required?" do
    subject{ helper.institution_version_required? }
    before { allow(helper).to receive(:nyulibraries_institutions_major_version).and_return major_version }

    context "when major version < 1" do
      let(:major_version){ 0 }

      it { is_expected.to be_falsy }
    end

    context "when major version = 1" do
      let(:major_version){ 1 }

      it { is_expected.to be_truthy }
    end

    context "when major version > 1" do
      let(:major_version){ 2 }

      it { is_expected.to be_truthy }
    end
  end

  describe "nyulibraries_institutions_major_version" do
    subject{ helper.nyulibraries_institutions_major_version }

    context "with NyulibrariesInstitutions defined" do
      let(:fake_institutions){ Class.new }

      before do
        stub_const("NyulibrariesInstitutions", fake_institutions)
        stub_const("NyulibrariesInstitutions::VERSION", version)
      end

      context "with first minor version" do
        let(:version){ "1.0.0" }

        it { is_expected.to eq 1 }
      end

      context "with later minor version" do
        let(:version){ "2.4.5" }

        it { is_expected.to eq 2 }
      end
    end
  end
end
