module NyulibrariesTemplates
  module ApplicationHelper
    # This engine
    def nyulibraries_templates
      ::Rails::Engine.subclasses.map(&:instance).find do |railtie|
        railtie.class.name.eql? NyulibrariesTemplates::Engine.name
      end
    end

    # Root of this engine
    def nyulibraries_templates_root
      nyulibraries_templates.root unless nyulibraries_templates.blank?
    end

    # Application title
    # Returns application.title_html from the locale
    def application_title
      t('application.title_html')
    end

    # Application stylesheet
    def application_stylesheet
      stylesheet_link_tag "application"
    end

    # Application javascript
    def application_javascript
      javascript_include_tag "application"
    end

    # Meta tags for the application
    def meta
      tag(:meta, :charset => "utf-8") +
      tag(:meta, :name => "viewport",
        :content => "width=device-width, initial-scale=1.0") +
      tag(:meta, :name => "HandheldFriendly", :content => "True") +
      tag(:meta, 'http-equiv' => "cleartype", :content => "on") +
      favicon_link_tag('https://library.nyu.edu/favicon.ico') +
      csrf_meta_tags
    end

    def institution_home_title
      views["breadcrumbs"]["title"]
    end

    def institution_home_url
      views["breadcrumbs"]["url"]
    end

    def parent_home_title
      (current_institution.link_to_parent.present?) ? institutions[current_institution.link_to_parent.to_sym].views["breadcrumbs"]["title"] : institution_home_title
    rescue NoMethodError
      institution_home_title
    end

    def parent_home_url
      (current_institution.link_to_parent.present?) ? institutions[current_institution.link_to_parent.to_sym].views["breadcrumbs"]["url"] : institution_home_url
    rescue NoMethodError
      institution_home_url
    end

    # Return true if delayed_jobs gem has any jobs running
    def delayed_jobs_running?
      (defined?(Delayed::Job) and Delayed::Job.count > 0)
    end
  end
end
