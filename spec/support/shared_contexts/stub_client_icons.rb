# ENGINE_ICON_PATH = File.expand_path(File.join(__FILE__, "../../../../config/icons.yml"))
# CLIENT_ICON_PATH = File.join(Rails.root, "config", "icons.yml")

RSpec.shared_context("stub client icons") do
  let(:client_icons){ {} }
  before do
    allow(File).to receive(:exists?).with(NyulibrariesTemplates::HtmlHelper::CLIENT_ICON_PATH).and_return true
    allow(YAML).to receive(:load_file).with(NyulibrariesTemplates::HtmlHelper::ENGINE_ICON_PATH).and_call_original
    allow(YAML).to receive(:load_file).with(NyulibrariesTemplates::HtmlHelper::CLIENT_ICON_PATH).and_return client_icons
  end
end
