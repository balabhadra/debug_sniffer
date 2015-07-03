require 'debug_sniffer/file_finder'
require 'debug_sniffer/parser'

module DebugSniffer  
  class DebugSniffer
    def initialize(directory, engine_config, io)
      @file_finder = FileFinder.new(engine_config)
      @files = @file_finder.files(directory)
      @parser = Parser.new(directory)
    end

    def run
      result = []
      @files.each do |file|
        result += @parser.parse(file)
      end
      result
    end
  end
end







