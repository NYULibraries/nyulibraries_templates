require 'rails_helper'

describe NyulibrariesTemplates::ApplicationHelper do
  describe "nyulibraries_templates_engine" do
    subject{ helper.nyulibraries_templates_engine }

    it { is_expected.to be_a NyulibrariesTemplates::Engine }
  end

  describe "nyulibraries_templates_root" do
    subject{ helper.nyulibraries_templates_root }
    let(:nyulibraries_templates){ double NyulibrariesTemplates::Engine }
    before do
      allow(helper).to receive(:nyulibraries_templates_engine).and_return nyulibraries_templates
    end

    it "should call root on nyulibraries_templates" do
      expect(nyulibraries_templates).to receive(:root)
      subject
    end
  end

  describe "application_title" do
    subject{ helper.application_title }

    it { is_expected.to eq "Dummy Application" }
  end

  describe "application_stylesheet" do
    subject{ helper.application_stylesheet }

    it "should call stylesheet_link_tag" do
      expect(helper).to receive(:stylesheet_link_tag).with("application")
      subject
    end
  end

  describe "application_javascript" do
    subject{ helper.application_javascript }

    it "should call stylesheet_link_tag" do
      expect(helper).to receive(:javascript_include_tag).with("application")
      subject
    end
  end

  describe "meta" do
    subject{ helper.meta }
    let(:favicon){ "--favicon--" }
    let(:csrf){ "--csrf--" }
    before do
      allow(helper).to receive(:favicon_link_tag).with('https://library.nyu.edu/favicon.ico').and_return favicon
      allow(helper).to receive(:csrf_meta_tags).and_return csrf
    end

    it { is_expected.to include '<meta charset="utf-8" />' }
    it { is_expected.to include '<meta name="viewport" content="width=device-width, initial-scale=1.0" />' }
    it { is_expected.to include '<meta name="HandheldFriendly" content="True" />' }
    it { is_expected.to include '<meta http-equiv="cleartype" content="on" />' }
    it { is_expected.to include favicon }
    it { is_expected.to include csrf }
  end

  describe "delayed_jobs_running?" do
    subject{ helper.delayed_jobs_running? }
    context "Delayed::Job not defined" do
      it { is_expected.to eq nil }
    end
    context "Delayed::Job is defined" do
      before do
        module Delayed
          class Job
            def self.count; 0; end
          end
        end
      end
      context "count is 0" do
        it { is_expected.to eq false }
      end
      context "count is positive" do
        before do
          allow(Delayed::Job).to receive(:count).and_return 1
        end
        it { is_expected.to eq true }
      end
    end
  end

  describe "onload" do
    subject{ helper.onload }

    it { is_expected.to eq nil }
  end

  describe "body_class" do
    subject{ helper.body_class }

    it { is_expected.to eq nil }
  end

  describe "body_id" do
    subject{ helper.body_id }

    it { is_expected.to eq nil }
  end

  describe "prepend_body" do
    subject{ helper.prepend_body }

    it { is_expected.to eq nil }
  end

  describe "prepend_yield" do
    subject{ helper.prepend_yield }

    it { is_expected.to eq nil }
  end
end
