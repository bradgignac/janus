require 'fileutils'

module Janus
  module Command
    class Initialize
      def execute
        if File.exists?('Janusfile')
          raise 'A configuration file already exists!'
        end

        FileUtils.copy(File.expand_path('../../template/Janusfile', __FILE__), 'Janusfile')
      end
    end
  end
end
