RSpec.shared_context "root_url defined" do
  let(:root_url){ nil }
  before do
    value = root_url
    helper.define_singleton_method(:root_url) do
      value
    end
    expect(helper.root_url).to eq root_url
  end
end
