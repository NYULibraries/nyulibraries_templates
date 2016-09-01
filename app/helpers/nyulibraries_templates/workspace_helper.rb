module NyulibrariesTemplates
  module WorkspaceHelper
    # Current user's name
    def current_user_name
      return unless defined?(current_user) && current_user
      [
        (current_user.firstname if current_user.respond_to?(:firstname)),
        (current_user.lastname if current_user.respond_to?(:lastname)),
      ].compact.join(" ")
    end

    # Guest name
    def guest_user_name
      t('workspace.guest_user_name_html')
    end

    # General workspace header
    def workspace_header
      content_tag(:h2, class: "workspace") do
        content_tag(:span, " #{t('workspace.header_html')}")
      end
    end
  end
end
