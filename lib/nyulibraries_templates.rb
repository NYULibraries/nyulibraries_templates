begin
  require 'nyulibraries_institutions'
rescue LoadError
end
require 'nyulibraries_templates/version'
require 'nyulibraries_templates/institution_version_helper'

module NyulibrariesTemplates
  class << self
    include NyulibrariesTemplates::InstitutionVersionHelper

    # modified from bootstrap-sass gem
    def load!
      register_rails_engine
      warn_institution_version unless institutions_included?
    end

    def warn_institution_version
      if !institutions_defined?
        warn "NyulibrariesInstitutions is not defined. Install gem 'nyulibraries_institutions' version >= #{MAJOR_VERSION_REQUIRED} to use institution functionality. Otherwise, layouts default to NYU."
      elsif !institution_version_required?
        warn "NyulibrariesInstitutions is defined with version < #{MAJOR_VERSION_REQUIRED}. Install gem 'nyulibraries_institutions' version >= #{MAJOR_VERSION_REQUIRED} to use institution functionality. Otherwise, layouts default to NYU."
      end
    end

    private

    def register_rails_engine
      require 'nyulibraries_templates/engine'
    end
  end
end

NyulibrariesTemplates.load!
