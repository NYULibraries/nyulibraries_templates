require 'rails_helper'

describe NyulibrariesTemplates::LoginHelper do
  include RSpecHtmlMatchers

  describe "login" do
    subject{ helper.login }

    context "with current_user defined" do
      include_context "current_user defined"

      context "returning nil" do
        let(:current_user){ nil }
        let(:link_to_login){ link_to "Login", "/path" }
        before { allow(helper).to receive(:link_to_login).and_return link_to_login }

        it { is_expected.to eq link_to_login }
      end

      context "returning an object" do
        let(:current_user){ Object.new }
        let(:link_to_logout){ link_to "Logout", "/path" }
        before { allow(helper).to receive(:link_to_logout).and_return link_to_logout }

        it { is_expected.to eq link_to_logout }
      end
    end

    context "without current_user defined" do
      it { is_expected.to eq nil }
    end
  end

  describe "link_to_logout" do
    subject{ helper.link_to_logout }

    context "with logout_url defined" do
      include_context "logout_url defined"
      let(:logout_url){ "/logout/path" }
      let(:logout_tag){ tag("i", class: "abc") }
      before { allow(helper).to receive(:icon_tag).with(:logout).and_return logout_tag }

      context "with username returning string" do
        let(:username){ "user 1" }
        before { allow(helper).to receive(:username).and_return username }

        it { is_expected.to have_tag "a", text: "Log-out #{username}", with: {class: "logout"} }
        it { is_expected.to include logout_tag }

        context "with params" do
          subject{ helper.link_to_logout(params) }
          let(:params){ {"some" => "thing"} }

          it { is_expected.to have_tag "a", text: "Log-out #{username}", with: {class: "logout"} }
          it { is_expected.to include logout_tag }
          it "should call logout_url" do
            expect(helper).to receive(:logout_url).with(params).and_return logout_url
            subject
          end
        end
      end

      context "with username returning nil" do
        let(:username){ nil }
        before { allow(helper).to receive(:username).and_return username }

        it { is_expected.to have_tag "a", text: "Log-out", with: {class: "logout"} }
        it { is_expected.to include logout_tag }

        context "with params" do
          subject{ helper.link_to_logout(params) }
          let(:params){ {"some" => "thing"} }

          it { is_expected.to have_tag "a", text: "Log-out", with: {class: "logout"} }
          it { is_expected.to include logout_tag }
          it "should call logout_url" do
            expect(helper).to receive(:logout_url).with(params).and_return logout_url
            subject
          end
        end
      end
    end

    context "without logout_url defined" do
      it { is_expected.to eq nil }
    end
  end

  describe "link_to_login" do
    subject{ helper.link_to_login }

    context "with login_url defined" do
      include_context "login_url defined"
      let(:login_url){ "/logout/path" }
      let(:login_tag){ tag("i", class: "xyz") }
      before { allow(helper).to receive(:icon_tag).with(:login).and_return login_tag }

      it { is_expected.to have_tag "a", text: "Login", with: {class: "login"} }
      it { is_expected.to include login_tag }
      it "should call login_url" do
        expect(helper).to receive(:login_url).with({}).and_return login_url
        subject
      end

      context "with params" do
        subject{ helper.link_to_login(params) }
        let(:params){ {"some" => "thing"} }

        it { is_expected.to have_tag "a", text: "Login", with: {class: "login"} }
        it { is_expected.to include login_tag }
        it "should call login_url" do
          expect(helper).to receive(:login_url).with(params).and_return login_url
          subject
        end
      end
    end

    context "without logout_url defined" do
      it { is_expected.to eq nil }
    end
  end

  describe "username" do
    subject{ helper.username }

    context "with current_user defined" do
      let(:fake_class){ Class.new }
      before { stub_const("DummyUser", fake_class) }
      include_context "current_user defined"

      context "with firstname defined" do
        let(:current_user){ double DummyUser, firstname: firstname }
        let(:fake_class) do
          Class.new do
            def firstname; end
          end
        end

        context "returning a string" do
          let(:firstname){ "Joe" }

          it { is_expected.to eq firstname }
        end

        context "returning nil" do
          let(:firstname){ nil }

          context "with username defined" do
            let(:current_user){ double DummyUser, firstname: firstname, username: username }
            let(:fake_class) do
              Class.new do
                def firstname; end
                def username; end
              end
            end

            context "returning nil" do
              let(:username){ nil }

              it { is_expected.to eq nil }
            end

            context "returning a string" do
              let(:username){ "joebob111" }

              it { is_expected.to eq username }
            end
          end

          context "without username defined" do
            it { is_expected.to eq nil }
          end
        end
      end

      context "with username defined" do
        let(:current_user){ double DummyUser, username: username }
        let(:fake_class) do
          Class.new do
            def username; end
          end
        end

        context "returning a string" do
          let(:username){ "Some Thing" }

          it { is_expected.to eq username }
        end

        context "returning nil" do
          let(:username){ nil }

          it { is_expected.to eq nil }
        end
      end

      context "without firstname or username defined" do
        let(:current_user){ double DummyUser }

        it { is_expected.to eq nil }
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
end
