RSpec.shared_context "current_user defined" do
  let(:current_user){ nil }
  before do
    value = current_user
    helper.define_singleton_method(:current_user) do
      value
    end
    expect(helper.current_user).to eq send(:current_user)
  end
end

RSpec.shared_context "login_url defined" do
  let(:login_url){ nil }
  before do
    value = login_url
    helper.define_singleton_method(:login_url) do |params={}|
      value
    end
    expect(helper.login_url).to eq send(:login_url)
  end
end

RSpec.shared_context "logout_url defined" do
  let(:logout_url){ nil }
  before do
    value = logout_url
    helper.define_singleton_method(:logout_url) do |params={}|
      value
    end
    expect(helper.logout_url).to eq send(:logout_url)
  end
end
