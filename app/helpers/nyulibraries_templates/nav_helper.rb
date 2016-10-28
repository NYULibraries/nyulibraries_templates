module NyulibrariesTemplates
  module NavHelper
    # Breadcrumbs
    def breadcrumbs
      breadcrumbs = []
      if breadcrumbs.empty?
        breadcrumbs << institution_breadcrumb if institution_breadcrumb
        breadcrumbs << link_to('BobCat', bobcat_breadcrumb_root)
      end
    end

    def bobcat_breadcrumb_root
      "#{bobcat_breadcrumb_base_url}/#{bobcat_breadcrumb_alias}"
    end
  end
end
