require 'debug_sniffer/rb_parser'
require 'debug_sniffer/js_parser'
require 'yaml'

module DebugSniffer
  # Parser Base class
  class Parser

    # Constructor
    # @param directory [String] path to files
    def initialize(directory)
      @directory = directory
      @file_config = YAML.load_file("config/config.yml")
      @keys = @file_config['debug_sniffer']['extensions'].keys
      @parser_hash = @keys.inject({}) do |val, key|
        val.merge!(key => @file_config['debug_sniffer']['extensions'][key]['parser'])
      end
    end

    # Instantiate and Invoke relevant parser methods
    # @param file [String] filename without path eg. shiva.rb
    # @return [Boolean]
    def parse(file)
      extension = File.extname(file).gsub('.','')
      camelized_parsers = @parser_hash[extension].map { |parser| camelize(parser) }
      camelized_parsers.each do |camelized_parser|
        file_path = File.join(@directory,file)
        eval(camelized_parser).new(file_path).parse
      end
    end

    private
    # Get Camelcase Class-name form snake-case string
    # @param str [String] eg file_parser
    # @return [String] eg FileParser
    def camelize(str)
      str.split('_').map { |w| w.capitalize }.join
    end
  end
end
