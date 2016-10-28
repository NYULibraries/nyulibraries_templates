require 'rails_helper'

describe NyulibrariesTemplates::PrintHelper do
  describe "print_title" do
    subject{ helper.print_title }
    let(:application_title){ "Some Title" }
    before { allow(helper).to receive(:application_title).and_return application_title }

    it { is_expected.to eq application_title }
    it "should call application_title" do
      expect(helper).to receive(:application_title)
      subject
    end
  end

  describe "print_stylesheet" do
    subject{ helper.print_stylesheet }
    let(:stylesheet_link_tag){ "xxxx" }
    before { allow(helper).to receive(:stylesheet_link_tag).and_return stylesheet_link_tag }

    it { is_expected.to eq stylesheet_link_tag }
    it "should call stylesheet_link_tag" do
      expect(helper).to receive(:stylesheet_link_tag).with("print", hash_including({media: :print}))
      subject
    end

    context "when called with media type" do
      subject{ helper.print_stylesheet(media) }
      let(:media){ :abcd }

      it { is_expected.to eq stylesheet_link_tag }
      it "should call stylesheet_link_tag" do
        expect(helper).to receive(:stylesheet_link_tag).with("print", hash_including({media: media}))
        subject
      end
    end
  end

  describe "print_stylesheet?" do
    subject{ helper.print_stylesheet? }

    it { is_expected.to be_falsy }
  end

  describe "print_javascript" do
    subject{ helper.print_javascript }
    let(:javascript_include_tag){ "xxxx" }
    before { allow(helper).to receive(:javascript_include_tag).and_return javascript_include_tag }

    it { is_expected.to eq javascript_include_tag }
    it "should call stylesheet_link_tag" do
      expect(helper).to receive(:javascript_include_tag).with("print")
      subject
    end
  end
end
