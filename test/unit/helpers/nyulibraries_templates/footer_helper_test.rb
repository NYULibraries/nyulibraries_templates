require 'test_helper'
module NyulibrariesTemplates
  class FooterHelperTest < ActionView::TestCase
    include NyulibrariesTemplates::FooterHelper

    test "library h3lp" do
      skip("Skipping for rails 4, Rails 4 handles html tags differntly") if(ActiveRecord::VERSION::MAJOR > 3)
      assert_equal("<script src=\"https://libraryh3lp.com/js/libraryh3lp.js?multi\" " +
        "type=\"text/javascript\"></script>", library_h3lp)
    end
  end
end
