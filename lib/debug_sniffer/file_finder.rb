require 'yaml'
module DebugSniffer
  class FileFinder
  
    def initialize(engine_config)
      @engine_config = engine_config
      file_config = YAML.load_file("config/config.yml")
      @relevant_type = file_config['debug_sniffer']['extensions'].keys
    end

    def files(directory)
      Dir.chdir(directory)
      files = []
      @relevant_type.each do |file_type|
        files += Dir.glob("**/*#{file_type}")
      end
      Dir.chdir('/usr/src/app')
      exclude_files(files)
    end

    private
    def exclude_files(files)
      exclusions = @engine_config['exclude_paths'] || []
      files.reject { |f| exclusions.include?(f) }
    end
  end
end
