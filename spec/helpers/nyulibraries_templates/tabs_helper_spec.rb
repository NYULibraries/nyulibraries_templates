module NyulibrariesTemplates
  module TabsHelper
    describe "tabs_header" do
      subject{ helper.tabs_header }
      let(:application_title){ "Some Title" }
      before { allow(helper).to receive(:application_title).and_return application_title }

      it { is_expected.to eq application_title }
      it "should call application_title" do
        expect(helper).to receive(:application_title)
        subject
      end
    end

    describe "show_tabs" do
      subject{ helper.show_tabs }

      context "with tabs empty" do
        let(:tabs){ [] }
        before { allow(helper).to receive(:tabs).and_return tabs }

        it { is_expected.to be_falsy }
      end

      context "with tabs non-empty" do
        let(:tabs){ [Object.new] }
        before { allow(helper).to receive(:tabs).and_return tabs }

        it { is_expected.to be_truthy }
      end
    end

    describe "tabs" do
      subject{ helper.tabs }

      context "with institution helpers" do
        include_context "include institution helpers"

        context "with institution_views" do
          context "with tabs" do
            let(:institution_views){ {"tabs" => tabs} }

            context "with complete data" do
              let(:tabs) do
                {
                  "abcd" => {"url" => "abc.example.com", "klass" => "abcde", "display" => true, "tip" => "Some text"},
                  "wxyz" => {"url" => "xyz.example.com", "klass" => "vwxyz", "display" => false, "tip" => "Other text"},
                }
              end
              before do
                allow(helper).to receive(:active_tab?).with("abcd").and_return false
                allow(helper).to receive(:active_tab?).with("wxyz").and_return true
              end

              it { is_expected.to eq [
                tabs["abcd"].merge({
                  "link" => helper.link_to_with_popover(true, "abc.example.com", "Some text", "tab")
                }),
                tabs["wxyz"].merge({
                  "link" => helper.link_to_with_popover(false, "xyz.example.com", "Other text", "tab")
                }),
              ] }

              context "with root_url defined" do
                include_context "root_url defined"
                let(:root_url){ "example.com" }

                it { is_expected.to eq [
                  tabs["abcd"].merge({
                    "link" => helper.link_to_with_popover(true, "abc.example.com", "Some text", "tab")
                  }),
                  tabs["wxyz"].merge({
                    "url" => "example.com",
                    "link" => helper.link_to_with_popover(false, "example.com", "Other text", "tab")
                  }),
                ] }
              end
            end
          end

          context "without tabs" do
            let(:institution_views){ {} }

            it { is_expected.to eq [] }
          end
        end

        context "with institution_views nil" do
          it { is_expected.to eq [] }
        end
      end

      context "without institution helpers" do
        before { allow(helper).to receive(:institutions_included?).and_return false }

        it { is_expected.to eq [] }
      end
    end

    describe "all_tabs" do
      it "should be an alias of tabs" do
        expect(helper.method(:all_tabs)).to eq helper.method(:tabs)
      end
    end

    describe "active_tab?" do
      subject{ helper.active_tab?(code) }
      let(:code){ "abcd" }

      context "with institution helpers" do
        include_context "include institution helpers"

        context "with current_institution with active_tab" do
          let(:current_institution){ double Object, active_tab: active_tab }

          context "matching code" do
            let(:active_tab){ "abcd" }

            it { is_expected.to be_truthy }
          end

          context "not matching code" do
            let(:active_tab){ "wxyz" }

            it { is_expected.to be_falsy }
          end
        end

        context "with current_institution without active_tab" do
          let(:current_institution){ Object.new }

          it { is_expected.to be_falsy }
        end

        context "with current_institution nil" do
          it { is_expected.to be_falsy }
        end
      end

      context "without institution helpers" do
        before { allow(helper).to receive(:institutions_included?).and_return false }

        it { is_expected.to be_falsy }
      end
    end
  end
end
