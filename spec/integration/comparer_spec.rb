require 'janus/comparer'
require 'janus/screenshot'
require 'janus/test'

describe Janus::Comparer do
  let(:square_base) { IO.read('spec/support/square-base.png', mode: 'rb') }
  let(:test) { Janus::Test.new(name: 'integration', url: 'example.com') }

  it 'succeeds for matching image' do
    original = Janus::Screenshot.new(test: test, image: square_base)
    fresh = Janus::Screenshot.new(test: test, image: square_base)

    expect { Janus::Comparer.compare(original, fresh) }.not_to raise_error
  end
end
