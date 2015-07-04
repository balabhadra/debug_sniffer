require 'debug_sniffer/file_finder'
require 'debug_sniffer/parser'

module DebugSniffer
  class DebugSniffer

    # @param directory [String] filepath
    # @param engine_config [hash] excludes the file

    attr_accessor :directory, :engine_config
    
    def initialize(directory, engine_config)
      @directory = directory || '/code'
      @engine_config = engine_config
    end

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







