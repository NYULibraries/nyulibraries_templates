require 'test_helper'
module NyulibrariesTemplates
    class NavHelperTest < ActionView::TestCase
      include NyulibrariesTemplates::NavHelper

      test "breadcrumbs" do
        skip
        assert_equal ["<a href=\"http://library.nyu.edu\">NYU Libraries</a>",
         "<a href=\"http://bobcat.library.nyu.edu/nyu\">BobCat</a>"], breadcrumbs
      end
    end
end
