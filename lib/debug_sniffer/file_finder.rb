require 'yaml'

module DebugSniffer
  class FileFinder
  
    attr_accessor :engine_config
    attr_reader :relevant_type
    
    def initialize(engine_config)
      @engine_config = engine_config
      file_config = YAML.load_file("config/config.yml")
      @relevant_type = file_config['debug_sniffer']['extensions'].keys
    end

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
    
    def exclude_files(files, pwd)
      Dir.chdir(pwd)
      exclusions = @engine_config['exclude_paths'] || []
      files.reject { |f| exclusions.include?(f) }
    end
  end
end
