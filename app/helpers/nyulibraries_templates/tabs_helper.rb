module NyulibrariesTemplates
  module TabsHelper
    # Tabs header for bootstrap responsive nav bar
    def tabs_header
      application_title
    end

    # Show tabs
    def show_tabs
      return !tabs.empty?
    end

    def tabs
      return [] unless institutions_included? && institution_views.try(:[], "tabs")
      institution_views["tabs"].collect do |code, values|
        values["code"] = code
        values["url"], values["klass"] = root_url, "active" if active_tab?(code) && defined?(root_url)
        values["link"] = link_to_with_popover(values["display"], values["url"], values["tip"], "tab")
        values
      end
    end
    alias all_tabs tabs

    # Is the given tab code active?
    def active_tab?(code)
      return unless institutions_included? && current_institution.respond_to?(:active_tab)
      current_institution.active_tab.eql?(code)
    end
  end
end
