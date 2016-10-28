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
      it { is_expected.to eq default_url }
    end
  end

  describe "institution_breadcrumb" do
    subject{ helper.institution_breadcrumb }

    context "with institution helpers" do
      include_context "include institution helpers"

      context "with institution_views" do
        let(:institution_views){ {"breadcrumbs" => {"url" => url, "title" => title}} }
        let(:url){ "example.com" }
        let(:title){ "Example" }

        it { is_expected.to eq link_to(title, url) }
      end

      context "without institution_views" do
        it { is_expected.to eq nil }
      end
    end

    context "without institution helpers" do
      it { is_expected.to eq nil }
    end
  end

  describe "bobcat_breadcrumb_base_url" do
    subject{ helper.bobcat_breadcrumb_base_url }
    let(:default_url){ "http://bobcat.library.nyu.edu" }

    context "with institution helpers" do
      include_context "include institution helpers"

      context "with current_institution with bobcat_alias" do
        let(:current_institution){ double Object, bobcat_url: bobcat_url }
        let(:bobcat_url){ "example.com" }

        it { is_expected.to eq bobcat_url }
      end

      context "without current_institution" do
        it { is_expected.to eq default_url }
      end
    end

    context "without institution helpers" do
      it { is_expected.to eq default_url }
    end
  end

  describe "bobcat_breadcrumb_alias" do
    subject{ helper.bobcat_breadcrumb_alias }
    let(:default_alias){ "nyu" }

    context "with institution helpers" do
      include_context "include institution helpers"

      context "with current_institution with bobcat_alias" do
        let(:current_institution){ double Object, bobcat_alias: bobcat_alias }
        let(:bobcat_alias){ "nyuad" }

        it { is_expected.to eq bobcat_alias }
      end

      context "without current_institution" do
        context "with institution_views" do
          let(:institution_views){ {"dir" => dir} }
          let(:dir){ "ns" }

          it { is_expected.to eq dir }
        end

        context "without institution_views" do
          it { is_expected.to eq default_alias }
        end
      end
    end

    context "without institution helpers" do
      it { is_expected.to eq default_alias }
    end
  end
end
