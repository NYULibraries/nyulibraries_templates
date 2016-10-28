require 'spec_helper'

describe NyulibrariesTemplates::NavHelper do
  describe "breadcrumbs" do
    subject{ helper.breadcrumbs }
    let(:default_link){ link_to "BobCat", "http://bobcat.library.nyu.edu/nyu" }

    context "with institution_breadcrumb" do
      let(:institution_breadcrumb){ link_to "Example", "http://example.com" }
      before { allow(helper).to receive(:institution_breadcrumb).and_return institution_breadcrumb }

      it { is_expected.to eq [institution_breadcrumb, default_link] }
    end

    context "without institution_breadcrumb" do
      before { allow(helper).to receive(:institution_breadcrumb).and_return nil }

      it { is_expected.to eq [default_link] }
    end
  end

  describe "bobcat_breadcrumb_root" do
    subject{ helper.bobcat_breadcrumb_root }
    let(:bobcat_breadcrumb_base_url){ "example.com" }
    let(:bobcat_breadcrumb_alias){ "abcd" }
    before do
      allow(helper).to receive(:bobcat_breadcrumb_base_url).and_return bobcat_breadcrumb_base_url
      allow(helper).to receive(:bobcat_breadcrumb_alias).and_return bobcat_breadcrumb_alias
    end

    it { is_expected.to eq "example.com/abcd" }
  end
end
