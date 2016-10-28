RSpec.shared_context("stub client icons") do
  let(:client_icons){ {} }
  before do
    allow(File).to receive(:exist?).with(NyulibrariesTemplates::HtmlHelper::CLIENT_ICON_PATH).and_return true
    allow(YAML).to receive(:load_file).with(NyulibrariesTemplates::HtmlHelper::ENGINE_ICON_PATH).and_call_original
    allow(YAML).to receive(:load_file).with(NyulibrariesTemplates::HtmlHelper::CLIENT_ICON_PATH).and_return client_icons
  end
end
