require 'yaml'
require 'janus/test'

module Janus
  class Configuration
    def self.load(*args)
      options = load_configuration_file
      options = args.reduce(options) do |all, opts|
        all.merge(opts)
      end

      Janus::Configuration.new(options)
    end

    def initialize(options = {})
      @options = options
    end

    def username
      @options['username']
    end

    def access_key
      @options['access_key']
    end

    def directory
      @options['directory']
    end

    def threshold
      @options['threshold'] || 0
    end

    def tests
      @options['tests'].map do |test|
        Janus::Test.new(test)
      end
    end

    private

    def self.load_configuration_file
      if File.exists?('Janusfile')
        YAML.load(::IO.read('Janusfile'))
      else
        raise 'Could not find Janus configuration file!'
      end
    end
  end
end
