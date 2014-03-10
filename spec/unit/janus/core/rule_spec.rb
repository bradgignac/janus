require 'janus/core/rule'

describe Janus::Core::DimensionsRule do
  let(:original) { double }
  let(:fresh) { double }

  describe '#execute' do
    it 'does not raise exception when dimensions are the same' do
      original.stub(:dimensions) { { width: 100, height: 100 } }
      fresh.stub(:dimensions) { { width: 100, height: 100 } }

      expect { subject.execute(original, fresh) }.not_to raise_error
    end

    it 'raises exception when dimensions are different' do
      original.stub(:dimensions) { { width: 100, height: 100 } }
      fresh.stub(:dimensions) { { width: 100, height: 200 } }

      expect { subject.execute(original, fresh) }.to raise_error(Janus::Core::ComparisonError)
    end
  end
end
