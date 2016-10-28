METHOD_NAMES = %w[current_institution institution_views institutions]

RSpec.shared_context "include institution helpers" do
  METHOD_NAMES.each do |method_name|
    let(method_name){ nil }
  end
  before do
    allow(helper).to receive(:institutions_included?).and_return true
    METHOD_NAMES.each do |method_name|
      value = send(method_name)
      helper.define_singleton_method(method_name) do
        value
      end
      expect(helper.send(method_name)).to eq send(method_name)
    end
  end
end
