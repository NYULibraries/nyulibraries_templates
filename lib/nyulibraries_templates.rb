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

# require 'nyulibraries_templates/controller_additions'

# module NyulibrariesTemplates
#     # class FrameworkNotFound < StandardError; end
#
#     require 'compass'
#     # require 'institutions'
#
#     # Inspired by {bootstrap-sass}[https://github.com/thomas-mcdonald/bootstrap-sass]
#     def self.load!
#       register_compass_extension
#       if asset_pipeline?
#         register_rails_engine
#       end
#       # Set the common institutions file at the front of the load paths.
#       # Institutions.loadpaths.unshift  File.join(File.dirname(__FILE__), '../', 'config')
#     end
#
#     private
#     def self.asset_pipeline?
#       defined?(::Rails) && ::Rails.version >= '3.1.0'
#     end
#
#     def self.register_compass_extension
#       # require 'bootstrap-sass'
#       base = File.join(File.dirname(__FILE__), "..")
#       # styles = File.join(base, "lib", "assets", "stylesheets")
#       # images = File.join(base, "lib", "assets", "images")
#       templates = File.join(base, "templates", "nyulibraries_templates")
#       ::Compass::Frameworks.register('nyulibraries-templates', path: base,
#         templates_directory: templates)
#       # ::Compass.configuration.sprite_load_path << images
#     end
#
#     def self.register_rails_engine
#       require 'nyulibraries_templates/engine'
#     end
# end
# # Load 'em up
# NyulibrariesTemplates.load!
