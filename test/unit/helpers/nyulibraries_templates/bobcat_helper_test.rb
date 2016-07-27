require 'test_helper'
module NyulibrariesTemplates
  class BobcatHelperTest < ActionView::TestCase
    include NyulibrariesTemplates::BobcatHelper

    test "application title" do
      assert_equal "BobCat", bobcat_title
    end
  end
end
