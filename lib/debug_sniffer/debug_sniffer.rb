require 'debug_sniffer/file_finder'
require 'debug_sniffer/parser'

module DebugSniffer  
  class DebugSniffer
    
    def initialize(directory, engine_config)
      file_finder = FileFinder.new(engine_config)
      @files = file_finder.files(directory)
      @parser = Parser.new(directory)
    end

    def run
      @files.each do |file|
        @parser.parse(file)
      end
    end
    
  end
end







