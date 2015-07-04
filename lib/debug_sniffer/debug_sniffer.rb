require 'debug_sniffer/file_finder'
require 'debug_sniffer/parser'

module DebugSniffer
  class DebugSniffer
    
    attr_accessor :directory, :engine_config
    
    # Initializer
    # @param directory [String] filepath
    # @param engine_config [Hash] Engine config from codeclimate

    def initialize(directory, engine_config)
      @directory = directory || '/code'
      @engine_config = engine_config
    end

    # Fed the files one by one to the Parser Instance
    # @return [Boolean]
    def run
      file_finder = FileFinder.new(@engine_config)
      files = file_finder.files(@directory)
      parser = Parser.new(@directory)
      
      files.each do |file|
        parser.parse(file)
      end
    end
  end
end







