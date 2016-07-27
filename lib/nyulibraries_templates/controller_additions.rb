module NyulibrariesTemplates
  module ControllerAdditions
    def self.included(base)
      base.prepend_before_action :include_template_class
    end
    
    def include_template_classes
      require find_template_class
    end
    
    private
    
    def find_template_class(path)
      
    end
  end
end

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include NyulibrariesTemplates::ControllerAdditions
  end
end