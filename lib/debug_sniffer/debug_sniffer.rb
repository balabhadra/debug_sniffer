require 'debug_sniffer/file_finder'
require 'debug_sniffer/parser'

module DebugSniffer
  class DebugSniffer
    # Constructor
    # @param directory [String] filepath
    # @param engine_config [Hash] excludes the file
    def initialize(directory, engine_config)
      file_finder = FileFinder.new(engine_config)
      @files = file_finder.files(directory)
      @parser = Parser.new(directory)
    end

    # Fed the files one by one to the Parser Instance
    # @return [Boolean]
    def run
      @files.each do |file|
        @parser.parse(file)
      end
    end
  end
end







