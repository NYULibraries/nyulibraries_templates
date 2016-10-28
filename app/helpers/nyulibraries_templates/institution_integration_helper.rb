module NyulibrariesTemplates
  module InstitutionIntegrationHelper
    def institution_home_title
      if institutions_included? && institution_views && institution_views["breadcrumbs"]
        institution_views["breadcrumbs"]["title"] || default_institution_data["breadcrumbs"]["title"]
      else
        default_institution_data["breadcrumbs"]["title"]
      end
    end

    def institution_home_url
      if institutions_included? && institution_views && institution_views["breadcrumbs"]
        institution_views["breadcrumbs"]["url"]
      else
        default_institution_data["breadcrumbs"]["url"]
      end
    end

    def parent_home_title
      if institutions_included?
        get_parent_home_title || institution_home_title
      else
        institution_home_title
      end
    end

    def parent_home_url
      if institutions_included?
        get_parent_home_url || institution_home_url
      else
        institution_home_url
      end
    end

    def institution_breadcrumb
      return unless institutions_included? && institution_views.try(:[], "breadcrumbs")
      link_to(institution_views["breadcrumbs"]["title"], institution_views["breadcrumbs"]["url"])
    end

    # Ensure there is always a bobcat url to show even if it isn't set anywhere
    def bobcat_breadcrumb_base_url
      if institutions_included?
        current_institution.try(:bobcat_url) || default_institution_data["bobcat_url"]
      else
        default_institution_data["bobcat_url"]
      end
    end

    # Ensure there is always an alias to show even if it isn't set anywhere
    def bobcat_breadcrumb_alias
      if institutions_included?
        current_institution.try(:bobcat_alias) || institution_views.try(:[], "dir") || default_institution_data["bobcat_alias"]
      else
        default_institution_data["bobcat_alias"]
      end
    end

    private

    def institutions_included?
      defined?(NyulibrariesInstitutions)
    end

    def get_parent_home_title
      parent_breadcrumbs.try(:[], "title")
    end

    def get_parent_home_url
      parent_breadcrumbs.try(:[], "url")
    end

    def parent_breadcrumbs
      return unless parent_institution && parent_institution.views
      parent_institution.views["breadcrumbs"]
    end

    def parent_institution
      return unless current_institution && current_institution.respond_to?(:link_to_parent) && institutions
      return unless link_to_parent = current_institution.link_to_parent
      @parent_institution ||= institutions[link_to_parent.to_sym]
    end

    def default_institution_data
      YAML.load(File.open(DEFAULT_INSTITUTION_FILE){|f| f.read }).with_indifferent_access
    end

    DEFAULT_INSTITUTION_FILE = File.expand_path(File.join(__FILE__, "..", "..", "..", "..", "config", "default_institution.yml"))

  end
end
