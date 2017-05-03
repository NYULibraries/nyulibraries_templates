require 'rails_helper'

describe NyulibrariesTemplates::FooterHelper do
  describe "library_h3lp" do
    subject{ helper.library_h3lp }

    it "should call javascript_include_tag" do
      expect(helper).to receive(:javascript_include_tag).with("https://libraryh3lp.com/js/libraryh3lp.js?multi")
      subject
    end
  end

  describe "gauges?" do
    subject{ helper.gauges? }

    include_examples "truthy_iff_production"
  end

  describe "gauges_tracking_code" do
    subject{ helper.gauges_tracking_code }

    it { is_expected.to eq nil }
  end

  describe "google_analytics?" do
    subject{ helper.google_analytics? }

    include_examples "truthy_iff_production"
  end

  describe "google_analytics_tracking_code" do
    subject{ helper.google_analytics_tracking_code }

    it { is_expected.to eq nil }
  end

  describe "google_tag_manager?" do
    subject{ helper.google_tag_manager? }

    include_examples "truthy_iff_production"
  end

  describe "google_tag_manager_tracking_code" do
    subject{ helper.google_tag_manager_tracking_code }

    it { is_expected.to eq nil }
  end

  describe "crazyegg?" do
    subject{ helper.crazyegg? }

    around do |example|
      with_modified_env(CRAZYEGG: crazyegg) do
        example.run
      end
    end

    context "when CRAZYEGG set to true" do
      let(:crazyegg){ 'true' }

      include_examples "truthy_iff_production"
    end

    context "when CRAZYEGG not set" do
      let(:crazyegg){ nil }

      it { is_expected.to be_falsy }
    end
  end

  describe "footer_html" do
    subject{ helper.footer_html }

    it { is_expected.to eq "NYU Division of Libraries" }
  end
end
