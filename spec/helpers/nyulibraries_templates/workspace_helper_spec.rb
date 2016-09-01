describe "rails_helper"

describe NyulibrariesTemplates::WorkspaceHelper do
  include RSpecHtmlMatchers

  describe "current_user_name" do
    subject{ helper.current_user_name }

    context "with current_user defined" do
      include_context "current_user defined"

      context "returning object with firstname and lastname" do
        let(:current_user){ double Object, firstname: "First", lastname: "Last" }

        it { is_expected.to eq "First Last" }
      end

      context "returning object without firstname" do
        let(:current_user){ double Object, lastname: "Last" }

        it { is_expected.to eq "Last" }
      end

      context "returning object without lastname" do
        let(:current_user){ double Object, firstname: "First" }

        it { is_expected.to eq "First" }
      end

      context "returning nil" do
        let(:current_user){ nil }

        it { is_expected.to eq nil }
      end
    end

    context "without current_user defined" do
      it { is_expected.to eq nil }
    end
  end

  describe "guest_user_name" do
    subject{ helper.guest_user_name }

    it { is_expected.to eq "Guest" }
  end

  describe "workspace_header" do
    subject{ helper.workspace_header }

    it "should have correct structure" do
      expect(subject).to have_tag "h2", with: {class: "workspace"} do
        with_tag "span", text: " My Workspace"
      end
    end
  end
end
