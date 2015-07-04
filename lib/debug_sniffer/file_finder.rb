require 'yaml'

module DebugSniffer
  # Searches for files supported in relevant directory
  class FileFinder

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
      Dir.chdir(directory)
      files = []
      @relevant_type.each do |file_type|
        files += Dir.glob("**/*.#{file_type}")
      end
      Dir.chdir('/usr/src/app')
      exclude_files(files)
    end

    private

    # Excludes files (path) set in config of .codeclimate.yml file
    # @param files [Array] collection of Files (String)
    def exclude_files(files)
      exclusions = @engine_config['exclude_paths'] || []
      files.reject { |f| exclusions.include?(f) }
    end
  end
end
