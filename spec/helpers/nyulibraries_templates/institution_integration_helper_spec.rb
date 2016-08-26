require 'rails_helper'

describe NyulibrariesTemplates::InstitutionIntegrationHelper do
  describe "institution_home_title" do
    subject{ helper.institution_home_title }

    context "with institution helpers" do
      include_context "include institution helpers"

      context "with valid views hash" do
        let(:institution_views){ {"breadcrumbs" => {"title" => title}} }
        let(:title){ "Something" }

        it { is_expected.to eq title }
      end
    end

    context "without institution helpers" do
      before { allow(helper).to receive(:institutions_included?).and_return false }

      it { is_expected.to eq "NYU Libraries" }
    end
  end

  describe "institution_home_url" do
    subject{ helper.institution_home_url }

    context "with institution helpers" do
      include_context "include institution helpers"

      context "with valid views hash" do
        let(:institution_views){ {"breadcrumbs" => {"url" => url}} }
        let(:url){ "example.com" }

        it { is_expected.to eq url }
      end
    end

    context "without institution helpers" do
      before { allow(helper).to receive(:institutions_included?).and_return false }

      it { is_expected.to eq "http://library.nyu.edu" }
    end
  end

  describe "parent_home_title" do
    subject{ helper.parent_home_title }
    let(:default_title){ "NYU Libraries" }

    context "with institution helpers" do
      include_context "include institution helpers" do
        let(:institutions){ [] }
      end

      context "with current_institution without link_to_parent" do
        let(:current_institution){ Object.new }

        it { is_expected.to eq default_title }
      end

      context "with current_institution with link_to_parent" do
        let(:current_institution){ double Object, link_to_parent: link_to_parent }
        let(:link_to_parent){ "NYU" }

        context "with matching institutions" do
          let(:institutions){ {NYU: parent_institution} }
          let(:parent_institution){ double Object, views: {"breadcrumbs" => {"title" => title}} }
          let(:title){ "Something" }

          it { is_expected.to eq title }
        end

        context "without matching institutions" do
          let(:institutions){ {} }

          it { is_expected.to eq default_title }
        end
      end

      context "without current_institution" do
        it { is_expected.to eq default_title }
      end
    end

    context "without institution helpers" do
      before { allow(helper).to receive(:institutions_included?).and_return false }

      it { is_expected.to eq default_title }
    end
  end

  describe "parent_home_url" do
    subject{ helper.parent_home_url }
    let(:default_url){ "http://library.nyu.edu" }

    context "with institution helpers" do
      include_context "include institution helpers" do
        let(:institutions){ [] }
      end

      context "with current_institution without link_to_parent" do
        let(:current_institution){ Object.new }

        it { is_expected.to eq default_url }
      end

      context "with current_institution with link_to_parent" do
        let(:current_institution){ double Object, link_to_parent: link_to_parent }
        let(:link_to_parent){ "NYU" }

        context "with matching institutions" do
          let(:institutions){ {NYU: parent_institution} }
          let(:parent_institution){ double Object, views: {"breadcrumbs" => {"url" => url}} }
          let(:url){ "example.com" }

          it { is_expected.to eq url }
        end

        context "without matching institutions" do
          let(:institutions){ {} }

          it { is_expected.to eq default_url }
        end
      end

      context "without current_institution" do
        it { is_expected.to eq default_url }
      end
    end

    context "without institution helpers" do
      before { allow(helper).to receive(:institutions_included?).and_return false }

      it { is_expected.to eq default_url }
    end
  end
end
