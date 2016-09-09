begin
  require 'nyulibraries_institutions'
rescue LoadError
end
require 'nyulibraries_templates/version'

module NyulibrariesTemplates
  class << self
    # modified from bootstrap-sass gem
    def load!
      register_rails_engine if rails?
      warn_institution_version unless institutions_included?
    end

    def warn_institution_version
      warn "NyulibrariesInstitutions is not defined. Install gem 'nyulibraries_institutions' to use institution functionality. Otherwise, layouts default to NYU."
    end

    def rails?
      defined?(::Rails)
    end

    private

    def institutions_included?
      defined?(NyulibrariesInstitutions)
    end

    def register_rails_engine
      require 'nyulibraries_templates/engine'
    end
  end
end

NyulibrariesTemplates.load!
