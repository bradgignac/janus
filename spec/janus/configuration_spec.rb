require 'janus/configuration'

describe Janus::Configuration do
  describe '::load' do
    it 'merges provided option hashes' do
      a = { a: '' }
      b = { b: '' }

      Janus::Configuration.should_receive(:new).with({ a: '', b: '' })

      Janus::Configuration.load(a, b)
    end

    it 'includes options from YAML configuration when files exists' do
      config = { b: '', c: '' }
      IO.stub(:read) { YAML.dump(config) }
      File.stub(:exists?) { |f| f == 'Janusfile' }

      Janus::Configuration.should_receive(:new).with({ a: '', b: '', c: '' })

      Janus::Configuration.load({ a: '' }, config)
    end
  end
end
