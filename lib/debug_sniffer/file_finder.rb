require 'yaml'

module DebugSniffer
  # Searches for files supported in relevant directory
  class FileFinder
  
    attr_accessor :engine_config
    attr_reader :relevant_type

    # Constructor
    # @param engine_config [Hash] excludes the file

    def initialize(engine_config)
      @engine_config = engine_config
      file_config = YAML.load_file("config/config.yml")
      @relevant_type = file_config['debug_sniffer']['extensions'].keys
    end

    # Gets all the files supported in relevant directory
    #   along with excludes the files (path) set in .codeclimate.yml
    # @param directory [String] path to files
    # @return [Array] collection of Files (String)
    def files(directory)
      pwd = Dir.pwd
      Dir.chdir(directory)
      files = []
      @relevant_type.each do |file_type|
        files += Dir.glob("**/*.#{file_type}")
      end
      exclude_files(files, pwd)
    end

    private

    # Excludes files (path) set in config of .codeclimate.yml file
    # @param files [Array] collection of Files (String)
    def exclude_files(files, pwd)
      Dir.chdir(pwd)
      exclusions = @engine_config['exclude_paths'] || []
      files.reject { |f| exclusions.include?(f) }
    end
  end
end
