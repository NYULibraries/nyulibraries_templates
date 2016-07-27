require 'test_helper'
module NyulibrariesTemplates
  class WorkspaceHelperTest < ActionView::TestCase
    include NyulibrariesTemplates::WorkspaceHelper

    test "current user name" do
      assert_equal "Dummy User", current_user_name
    end

    test "guest user name" do
      assert_equal "Guest", guest_user_name
    end
  end
end
