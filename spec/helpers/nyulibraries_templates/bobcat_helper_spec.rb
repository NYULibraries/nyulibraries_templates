require 'rails_helper'

describe NyulibrariesTemplates::BobcatHelper do
  describe "bobcat_title" do
    subject{ helper.bobcat_title }

    it { is_expected.to eq "BobCat" }
  end
end
