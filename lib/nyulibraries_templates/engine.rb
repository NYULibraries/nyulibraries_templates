module NyulibrariesTemplates
  class Engine < ::Rails::Engine
    # So we don't overlap in client namespace
    isolate_namespace NyulibrariesTemplates

    # Include the view path in the client application
    ActionController::Base.append_view_path(File.join(root, 'app', 'templates', 'nyulibraries_templates'))

    # Include the helper in the client application
    initializer "nyulibraries_templates.view_helpers" do
      ActiveSupport.on_load(:action_view) do
        include NyulibrariesTemplates::ApplicationHelper
        include NyulibrariesTemplates::BobcatHelper
        include NyulibrariesTemplates::FooterHelper
        include NyulibrariesTemplates::HtmlHelper
        include NyulibrariesTemplates::InstitutionIntegrationHelper
        include NyulibrariesTemplates::LoginHelper
        include NyulibrariesTemplates::PrintHelper
        include NyulibrariesTemplates::NavHelper
        include NyulibrariesTemplates::TabsHelper
        include NyulibrariesTemplates::WorkspaceHelper
      end
    end

    config.generators do |g|
      g.test_framework :rspec, :fixture => false
      g.assets false
      g.helper false
    end
  end
end
