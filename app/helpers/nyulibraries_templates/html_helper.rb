module NyulibrariesTemplates
  module HtmlHelper
    # Returns a link with a Bootstrap popover
    def link_to_with_popover(title, link, content, klass=nil)
      link_to(title, link, class: klass, title: title, data: {content: "<div class=\"#{klass}\">#{content}</div>"})
    end

    # Returns a sidebar section, complete with Bootstrap responsive navbar and collapsing.
    # Example1 - closed sidebar section:
    #     <%= sidebar_section("help", content_tag(:h2, "Need help?")) do %>
    #       <ul class="nav-list">
    #         <li><a href="http://library.nyu.edu/help/ejournals.html" target="_blank">Help using the E-Journals A-Z tab</a></li>
    #         <li><a href="http://library.nyu.edu/research/tutorials/" target="_blank">Tutorials and self help</a></li>
    #         <li><a href="http://library.nyu.edu/ask" target="_blank" id="ny_aal">Ask a Librarian</a></li>
    #       </ul>
    #     <% end %>
    # Example2 - Open sidebar section:
    #     <%= sidebar_section("help", content_tag(:h2, "3 Squares", title: "for breakfast"), true) do %>
    #       <%= content_tag(:h3, "First Breakfast") %>
    #       <p>Coffee and eggs</p>
    #       <%= content_tag(:h3, "Second Breakfast") %>
    #       <ul>
    #         <li>Oatmeal</li>
    #         <li>More Coffee</li>
    #       </ul>
    #       <%= content_tag(:h3, "Third Breakfast") %>
    #       <ul>
    #         <%= content_tag(:li, "Pancakes") %>
    #       </ul>
    #     <% end %>
    def sidebar_section(id, header, open = false, &block)
      collapse_classes = ["navbar-collapse", "collapse", "sidebar-section"]
      style = ""
      if open
        collapse_classes << "in"
        style = "height: auto;"
      end
      content_tag(:nav, class: ["navbar", "navbar-default"]) do
        content_tag(:div, class: "navbar-header") do
          content_tag(:button, class: ["navbar-toggle", "collapsed"], type: "button", data: {toggle: "collapse", target: "##{id}.navbar-collapse"}, 'aria-label' => "Toggle menu - #{header}") do
            content_tag(:span, nil, class: "icon-bar") + content_tag(:span, nil, class: "icon-bar")
          end + header
        end + content_tag(:div, id: id, class: collapse_classes, style: style, &block)
      end
    end

    # Returns a Bootstrap button dropdown menu
    def button_dropdown(title, list, toggle_button = true)
      dropdown(title, list, toggle_button, {class: ["btn-group"]}, {class: ["btn", "btn-default", "dropdown-toggle"]})
    end

    # Returns a Bootstrap button dropdown menu, pulled right
    def right_button_dropdown(title, list, toggle_button = true)
      dropdown(title, list, toggle_button, {class: ["btn-group", "pull-right"]}, {class: ["btn", "btn-default", "dropdown-toggle"]}, {class: ["pull-right", "dropdown-menu"]})
    end

    # Returns a Bootstrap dropdown
    def dropdown(title, list, toggle_button = true, html_options = {class: "dropdown"}, toggle_html_options = {class: "dropdown-toggle"}, menu_html_options = {class: "dropdown-menu"})
      data_toggle_option = {data: {toggle: "dropdown"}}
      toggle_html_options.deep_merge!(data_toggle_option)
      button_html_options = {class: ["btn", "btn-default"]}
      button_html_options.deep_merge!(data_toggle_option) if toggle_button
      content_tag(:div, html_options) do
        content_tag(:button, title, button_html_options) +
        # Need to explicitly add margin-top for firefox. WTF?
        content_tag(:button, toggle_html_options) { content_tag(:span, nil, class: "caret") } +
        content_tag(:ul, menu_html_options.merge(role: "menu")) do
          list.map do |member|
            content_tag(:li){ member }
          end.join.html_safe
        end
      end
    end

    # # Will output HTML pagination controls. Modeled after blacklight helpers/blacklight/catalog_helper_behavior.rb#paginate_rsolr_response
    # # Equivalent to kaminari "paginate", but takes a Sunspot response as first argument.
    # # Will convert it to something kaminari can deal with (using #paginate_params), and
    # # then call kaminari page_entries_info with that. Other arguments (options and block) same as
    # # kaminari paginate, passed on through.
    # def page_entries_info_sunspot(response, options = {}, &block)
    #   per_page = response.results.count
    #   per_page = 1 if per_page < 1
    #   current_page = (response.results.offset / per_page).ceil + 1
    #   page_entries_info Kaminari.paginate_array(response.results, total_count: response.total).page(current_page).per(per_page), options, &block
    # end

    # Return link with a Bootstrap tooltip
    def tooltip_tag(content, title, url = "#", placement = "right", css_classes = "help-inline record-help")
      link_to(content, url, class: css_classes, data: { placement: placement }, rel: "tooltip", target: "_blank", title: title)
    end

    # Retrieve a value matching a key to an icon class name
    def icons(key)
      (icons_info[key.to_s] || key)
    end

    # Load the icons YAML info file
    def icons_info
      @icons_info ||= icons_file
    end

    ENGINE_ICON_PATH = File.expand_path(File.join(__FILE__, "..", "..", "..", "..", "config", "icons.yml"))
    CLIENT_ICON_PATH = File.join(Rails.root, "config", "icons.yml")

    # Load the local icons first and then the app icons if exist
    def icons_file
      @icons_file = YAML.load_file(ENGINE_ICON_PATH)
      @icons_file.merge!(YAML.load_file(CLIENT_ICON_PATH)) if File.exist?(CLIENT_ICON_PATH)
      return @icons_file
    end

    # Generate an icon tag with class key
    def icon_tag(key)
      content_tag :i, nil, class: icons(key)
    end

    # Returns an NYU Libraries content type figure for the given content type
    def content_type_tag(content_type)
      raise ArgumentError, "content_type must be a string" unless content_type.is_a? String
      content_tag(:figure, class: "content-type") do
        content_tag(:i, nil, class: "icons-nyu-content-type-#{content_type.downcase}") +
          content_tag(:figcaption, content_type.capitalize.tr("_", " "))
      end
    end

    def new_window_span
      content_tag(:span, t('application.new_window_text'), class: 'sr-only')
    end
  end
end
