require 'rails_helper'
# load 'app/helpers/nyulibraries_templates/application_helper.rb'

describe NyulibrariesTemplates::ApplicationHelper do
  # let(:helper){ Class.new{ extend NyulibrariesTemplates::ApplicationHelper }}

  describe "application_stylesheet" do
    subject{ helper.application_stylesheet }

    it "should call stylesheet_link_tag" do
      expect(helper).to receive(:stylesheet_link_tag).with("application")
      subject
    end
  end
end
