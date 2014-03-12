require 'janus/configuration'
require 'janus/command/initialize'

describe Janus::Command::Initialize do
  let(:command) { Janus::Command::Initialize.new }

  describe '#execute' do
    it 'writes samples configuration if file does not exist' do
      File.stub(:exists?) { false }

      source = File.expand_path('../../../../../lib/janus/template/Janusfile', __FILE__)
      destination = 'Janusfile'
      FileUtils.should_receive(:copy).with(source, destination)

      command.execute
    end

    it 'raises error if file already exists' do
      File.stub(:exists?) { true }

      expect { command.execute }.to raise_error('A configuration file already exists!')
    end
  end
end
