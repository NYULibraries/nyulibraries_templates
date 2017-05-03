module NyulibrariesTemplates
  module FooterHelper
    # Library H3lp javascript
    def library_h3lp
      javascript_include_tag "https://libraryh3lp.com/js/libraryh3lp.js?multi"
    end

    # Using Gauges? Only in production!
    def gauges?
      Rails.env.production?
    end

    # Placeholder.
    def gauges_tracking_code
    end

    # Using Google Analytics? Only in production!
    def google_analytics?
      Rails.env.production?
    end

    # Placeholder.
    def google_analytics_tracking_code
    end

    # Using Google Tag Manager? Only in production!
    def google_tag_manager?
      Rails.env.production?
    end

    # Placeholder.
    def google_tag_manager_tracking_code
    end

    # Using Crazyegg? Only in production! and when CRAZYEGG env var is set
    def crazyegg?
      ENV["CRAZYEGG"] && Rails.env.production?
    end

    def footer_html
      t('footer.footer_html')
    end
  end
end
