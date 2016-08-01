require 'nyulibraries_institutions'
require 'nyulibraries_templates/version'

module NyulibrariesTemplates
  class << self
    # modified from bootstrap-sass gem
    def load!
      register_rails_engine if rails?
    end

    def rails?
      defined?(::Rails)
    end

    private

    def register_rails_engine
      require 'nyulibraries_templates/engine'
    end
  end
end

NyulibrariesTemplates.load!
