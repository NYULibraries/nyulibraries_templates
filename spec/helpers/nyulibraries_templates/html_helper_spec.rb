require 'rails_helper'

describe NyulibrariesTemplates::HtmlHelper do
  include RSpecHtmlMatchers

  describe "link_to_with_popover" do
    subject{ helper.link_to_with_popover(title, link, popover_content) }
    let(:title){ "Testing" }
    let(:link){ "/some/path" }
    let(:popover_content){ "something to say" }

    it "should have correct structure" do
      expect(subject).to have_tag("a", with: {
        href: link,
        title: title,
        "data-content" => "<div class=\"\">#{popover_content}</div>"
      })
    end

    context "with class" do
      subject{ helper.link_to_with_popover(title, link, popover_content, klass) }
      let(:klass){ "hello" }

      it "should have correct structure" do
        expect(subject).to have_tag("a", with: {
          href: link,
          title: title,
          class: klass,
          "data-content" => "<div class=\"#{klass}\">#{popover_content}</div>"
        })
      end
    end
  end

  describe "sidebar_section" do
    subject{ helper.sidebar_section(id, header){ content } }
    let(:id){ "some" }
    let(:header){ "Some Title" }
    let(:content){ helper.content_tag("div", "something new") }

    it "should have correct structure" do
      expect(subject).to have_tag("nav", with: {class: %w[navbar navbar-default]}) do
        with_tag("div", with: {class: "navbar-header"}) do
          with_text header
          with_tag("button", with: {class: %w[navbar-toggle collapsed], type: "button", "data-toggle" => "collapse", "data-target" => "##{id}.navbar-collapse"}) do
            with_tag("span", with: {class: "icon-bar"})
            with_tag("span", with: {class: "icon-bar"})
          end
        end
        with_tag("div", with: {id: id, class: %w[navbar-collapse collapse sidebar-section]}) do
          with_tag("div", text: "something new")
        end
      end
    end

    context "with open on" do
      subject{ helper.sidebar_section(id, header, true){ content } }

      it "should have correct structure" do
        expect(subject).to have_tag("nav", with: {class: %w[navbar navbar-default]}) do
          with_tag("div", with: {class: "navbar-header"}) do
            with_text header
            with_tag("button", with: {class: %w[navbar-toggle collapsed], type: "button", "data-toggle" => "collapse", "data-target" => "##{id}.navbar-collapse"}) do
              with_tag("span", with: {class: "icon-bar"})
              with_tag("span", with: {class: "icon-bar"})
            end
          end
          with_tag("div", with: {id: id, class: %w[navbar-collapse collapse sidebar-section in], style: "height: auto;"}) do
            with_tag("div", text: "something new")
          end
        end
      end
    end
  end

  describe "button_dropdown" do
    subject{ helper.button_dropdown(title, list) }
    let(:title){ "Test Title" }
    let(:list){ ["Test Value 1","Test Value 2"] }
    let(:str){ "<div class=\"btn-group\"><button class=\"btn btn-default\" data-toggle=\"dropdown\">Test Title</button><button class=\"btn btn-default dropdown-toggle\" data-toggle=\"dropdown\"><span class=\"caret\"></span></button><ul class=\"dropdown-menu\" role=\"menu\"><li>Test Value 1</li><li>Test Value 2</li></ul></div>" }

    it "should have correct structure" do
      expect(subject).to have_tag("div", with: {class: "btn-group"}) do
        with_tag("button", with: {class: %w[btn btn-default], "data-toggle" => "dropdown"}) do
          with_text title
        end
        with_tag("button", with: {class: %w[btn btn-default dropdown-toggle], "data-toggle" => "dropdown"}) do
          with_tag("span", with: {class: "caret"})
        end
        with_tag("ul", with: {class: "dropdown-menu", role: "menu"}) do
          with_tag("li", text: "Test Value 1")
          with_tag("li", text: "Test Value 2")
        end
      end
    end

    context "with toggle off" do
      subject{ helper.button_dropdown(title, list, false) }

      it "should have correct structure" do
        expect(subject).to have_tag("div", with: {class: "btn-group"}) do
          with_tag("button", with: {class: %w[btn btn-default]}) do
            with_text title
          end
          with_tag("button", with: {class: %w[dropdown-toggle], "data-toggle" => "dropdown"}) do
            with_tag("span", with: {class: "caret"})
          end
          with_tag("ul", with: {class: "dropdown-menu", role: "menu"}) do
            with_tag("li", text: "Test Value 1")
            with_tag("li", text: "Test Value 2")
          end
        end
      end
    end
  end

  describe "dropdown" do
    subject{ helper.dropdown(title, list) }
    let(:title){ "Something Great" }
    let(:list){ ["One thing", "Two thing"] }

    it "should have correct structure" do
      expect(subject).to have_tag("div", with: {class: "dropdown"}) do
        with_tag("button", with: {class: %w[btn btn-default], "data-toggle" => "dropdown"}) do
          with_text title
        end
        with_tag("button", with: {class: %w[dropdown-toggle], "data-toggle" => "dropdown"}) do
          with_tag("span", with: {class: "caret"})
        end
        with_tag("ul", with: {class: "dropdown-menu", role: "menu"}) do
          with_tag("li", text: "One thing")
          with_tag("li", text: "Two thing")
        end
      end
    end

    context "with toggle off" do
      subject{ helper.dropdown(title, list, false) }

      it "should have correct structure" do
        expect(subject).to have_tag("div", with: {class: "dropdown"}) do
          with_tag("button", with: {class: %w[btn btn-default]}) do
            with_text title
          end
          with_tag("button", with: {class: %w[dropdown-toggle], "data-toggle" => "dropdown"}) do
            with_tag("span", with: {class: "caret"})
          end
          with_tag("ul", with: {class: "dropdown-menu", role: "menu"}) do
            with_tag("li", text: "One thing")
            with_tag("li", text: "Two thing")
          end
        end
      end
    end

    context "with html_options" do
      subject{ helper.dropdown(title, list, true, {class: "new_class", data: {test: "something"}}) }

      it "should have correct structure" do
        expect(subject).to have_tag("div", with: {class: "new_class", "data-test" => "something"}) do
          with_tag("button", with: {class: %w[btn btn-default], "data-toggle" => "dropdown"}) do
            with_text title
          end
          with_tag("button", with: {class: %w[dropdown-toggle], "data-toggle" => "dropdown"}) do
            with_tag("span", with: {class: "caret"})
          end
          with_tag("ul", with: {class: "dropdown-menu", role: "menu"}) do
            with_tag("li", text: "One thing")
            with_tag("li", text: "Two thing")
          end
        end
      end

      context "with toggle_html_options" do
        subject{ helper.dropdown(title, list, true, {class: "new_class"}, {class: "other_class", data: {test: "something"}}) }

        it "should have correct structure" do
          expect(subject).to have_tag("div", with: {class: "new_class"}) do
            with_tag("button", with: {class: %w[btn btn-default], "data-toggle" => "dropdown"}) do
              with_text title
            end
            with_tag("button", with: {class: "other_class", "data-test" => "something", "data-toggle" => "dropdown"}) do
              with_tag("span", with: {class: "caret"})
            end
            with_tag("ul", with: {class: "dropdown-menu", role: "menu"}) do
              with_tag("li", text: "One thing")
              with_tag("li", text: "Two thing")
            end
          end
        end

        context "with toggle off" do
          subject{ helper.dropdown(title, list, false, {class: "new_class"}, {class: "other_class", data: {test: "something"}}) }

          it "should have correct structure" do
            expect(subject).to have_tag("div", with: {class: "new_class"}) do
              with_tag("button", with: {class: %w[btn btn-default]}) do
                with_text title
              end
              with_tag("button", with: {class: "other_class", "data-test" => "something", "data-toggle" => "dropdown"}) do
                with_tag("span", with: {class: "caret"})
              end
              with_tag("ul", with: {class: "dropdown-menu", role: "menu"}) do
                with_tag("li", text: "One thing")
                with_tag("li", text: "Two thing")
              end
            end
          end
        end

        context "with menu_html_options" do
          subject{ helper.dropdown(title, list, true, {class: "new_class"}, {class: "other_class"}, {class: "other_thing", data: {test: "something"}}) }

          it "should have correct structure" do
            expect(subject).to have_tag("div", with: {class: "new_class"}) do
              with_tag("button", with: {class: %w[btn btn-default], "data-toggle" => "dropdown"}) do
                with_text title
              end
              with_tag("button", with: {class: "other_class", "data-toggle" => "dropdown"}) do
                with_tag("span", with: {class: "caret"})
              end
              with_tag("ul", with: {class: "other_thing", role: "menu", "data-test" => "something"}) do
                with_tag("li", text: "One thing")
                with_tag("li", text: "Two thing")
              end
            end
          end
        end
      end # end context "with toggle_html_options"
    end # end context "with html_options"
  end

  describe "right_button_dropdown" do
    subject{ helper.right_button_dropdown(title, list) }
    let(:title){ "Test Title" }
    let(:list){ ["Test Value 1","Test Value 2"] }
    let(:str){ "<div class=\"btn-group pull-right\"><button class=\"btn btn-default\" data-toggle=\"dropdown\">Test Title</button><button class=\"btn btn-default dropdown-toggle\" data-toggle=\"dropdown\"><span class=\"caret\"></span></button><ul class=\"pull-right dropdown-menu\" role=\"menu\"><li>Test Value 1</li><li>Test Value 2</li></ul></div>" }

    # it { is_expected.to have_tag "div", with: {class: "btn-group pull-right"} }
    # it { is_expected.to have_tag("div"){ with_tag("button"); with_tag("button"){ with_tag("span") }; with_tag("ul") } }
    # it { is_expected.to have_tag("div"){ with_tag "button", with: {class: "btn btn-default", "data-toggle" => "dropdown"} } }
    # it { is_expected.to have_tag("div"){ with_tag "button", with: {class: "btn btn-default dropdown-toggle", "data-toggle" => "dropdown"} } }
    it "should have correct structure" do
      expect(subject).to have_tag("div", with: {class: "btn-group pull-right"}) do
        with_tag("button", with: {class: %w[btn btn-default], "data-toggle" => "dropdown"}) do
          with_text "Test Title"
        end
        with_tag("button", with: {class: %w[btn btn-default dropdown-toggle], "data-toggle" => "dropdown"}) do
          with_tag("span", with: {class: "caret"})
        end
        with_tag("ul", with: {class: %w[pull-right dropdown-menu], role: "menu"}) do
          with_tag("li", text: "Test Value 1")
          with_tag("li", text: "Test Value 2")
        end
      end
    end

    context "with toggle off" do
      subject{ helper.right_button_dropdown(title, list, false) }

      it "should have correct structure" do
        expect(subject).to have_tag("div", with: {class: "btn-group pull-right"}) do
          with_tag("button", with: {class: "btn btn-default"}) do
            with_text "Test Title"
          end
          with_tag("button", with: {class: "btn btn-default dropdown-toggle", "data-toggle" => "dropdown"}) do
            with_tag("span", with: {class: "caret"})
          end
          with_tag("ul", with: {class: %w[pull-right dropdown-menu], role: "menu"}) do
            with_tag("li", text: "Test Value 1")
            with_tag("li", text: "Test Value 2")
          end
        end
      end
    end
  end

  describe "tooltip_tag" do
    subject{ helper.tooltip_tag(content, title) }

    context "with content and title" do
      let(:content){ "This is a test tooltip" }
      let(:title){ "test" }

      # it { is_expected.to have_tag 'a', with: {href: '#'} }
      # it { is_expected.to have_tag 'a', with: {class: "help-inline record-help"} }
      # it { is_expected.to have_tag 'a', with: {} }
      # it { is_expected.to have_tag 'a', with: {rel: "tooltip"} }
      # it { is_expected.to have_tag 'a', with: {target: "_blank"} }
      # it { is_expected.to have_tag 'a', with: {title: title} }
      # it { is_expected.to have_tag 'a', text: content }

      it "should be structured correctly" do
        expect(subject).to have_tag('a', text: content, with: {
          href: '#',
          class: "help-inline record-help",
          rel: "tooltip",
          target: "_blank",
          title: title,
          "data-placement" => "right"
        })
      end
    end
  end

  describe "icons" do
    subject{ helper.icons(key) }
    let(:icons_info) do
      {
        "sort_desc" => "icons-famfamfam-arrow_down",
        "sort_asc" => "icons-famfamfam-arrow_up",
      }
    end
    before { allow(helper).to receive(:icons_info).and_return icons_info }

    context "with key in yaml" do
      let(:key){ "sort_asc" }

      it { is_expected.to eq "icons-famfamfam-arrow_up" }
    end

    context "with symbol key in yaml as string" do
      let(:key){ :sort_asc }

      it { is_expected.to eq "icons-famfamfam-arrow_up" }
    end

    context "with key not in yaml" do
      let(:key){ "something_else" }

      it { is_expected.to eq key }
    end
  end

  describe "icons_info" do
    subject{ helper.icons_info }
    context "with client icons" do
      include_context "stub client icons"
      let(:client_icons) do
        {
          "logout" => "icons-famfamfam-lock_override",
          "addition" => "icon-added",
        }
      end

      it { is_expected.to eq ({
        "sort_desc" => "icons-famfamfam-arrow_down",
        "sort_asc" => "icons-famfamfam-arrow_up",
        "info" => "icons-famfamfam-information",
        "help" => "icons-famfamfam-help",
        "show" => "icons-famfamfam-magnifier",
        "back" => "icons-famfamfam-arrow_undo",
        "add" => "icons-famfamfam-add",
        "edit" => "icons-famfamfam-wrench",
        "login" => "icons-famfamfam-lock_open",
        "logout" => "icons-famfamfam-lock_override",
        "addition" => "icon-added",
      }) }
    end

    context "without client icons" do
      it { is_expected.to eq ({
        "sort_desc" => "icons-famfamfam-arrow_down",
        "sort_asc" => "icons-famfamfam-arrow_up",
        "info" => "icons-famfamfam-information",
        "help" => "icons-famfamfam-help",
        "show" => "icons-famfamfam-magnifier",
        "back" => "icons-famfamfam-arrow_undo",
        "add" => "icons-famfamfam-add",
        "edit" => "icons-famfamfam-wrench",
        "login" => "icons-famfamfam-lock_open",
        "logout" => "icons-famfamfam-lock",
      }) }
    end
  end

  describe "icons_file" do
    subject{ helper.icons_file }

    context "with client icons" do
      include_context "stub client icons"
      let(:client_icons) do
        {
          "logout" => "icons-famfamfam-lock_override",
          "addition" => "icon-added",
        }
      end

      it { is_expected.to eq ({
        "sort_desc" => "icons-famfamfam-arrow_down",
        "sort_asc" => "icons-famfamfam-arrow_up",
        "info" => "icons-famfamfam-information",
        "help" => "icons-famfamfam-help",
        "show" => "icons-famfamfam-magnifier",
        "back" => "icons-famfamfam-arrow_undo",
        "add" => "icons-famfamfam-add",
        "edit" => "icons-famfamfam-wrench",
        "login" => "icons-famfamfam-lock_open",
        "logout" => "icons-famfamfam-lock_override",
        "addition" => "icon-added",
      }) }
    end

    context "without client icons" do
      it { is_expected.to eq ({
        "sort_desc" => "icons-famfamfam-arrow_down",
        "sort_asc" => "icons-famfamfam-arrow_up",
        "info" => "icons-famfamfam-information",
        "help" => "icons-famfamfam-help",
        "show" => "icons-famfamfam-magnifier",
        "back" => "icons-famfamfam-arrow_undo",
        "add" => "icons-famfamfam-add",
        "edit" => "icons-famfamfam-wrench",
        "login" => "icons-famfamfam-lock_open",
        "logout" => "icons-famfamfam-lock",
      }) }
    end
  end

  describe "icon_tag" do
    subject{ helper.icon_tag(key) }
    let(:key){ "key" }
    let(:icon){ "icon" }
    before { allow(helper).to receive(:icons).with(key).and_return icon }

    it { is_expected.to have_tag("i", with: {class: icon}) }
    it { is_expected.to include "</i>" } # needs closing tag
  end

  describe "content_type_tag" do
    subject{ helper.content_type_tag(content_type) }

    context "with context_type string" do
      let(:content_type){ "essay" }

      # it { is_expected.to have_tag("figure", with: {class: "content-type"}) }
      # it { is_expected.to have_tag("figure"){ with_tag("i"); with_tag("figcaption") } }
      # it { is_expected.to have_tag("figure"){ with_tag "i", with: {class: "icons-nyu-content-type-essay"} } }
      # it { is_expected.to have_tag("figure"){ with_tag "figcaption", "Essay" } }

      it "should have correct structure" do
        expect(subject).to have_tag("figure", with: {class: "content-type"}) do
          with_tag("i", with: {class: "icons-nyu-content-type-essay"})
          with_tag("figcaption", "Essay")
        end
      end
    end

    context "with content_type nil" do
      let(:content_type){ nil }

      it "should raise correct error" do
        expect{ subject }.to raise_error ArgumentError, "content_type must be a string"
      end
    end
  end
end
