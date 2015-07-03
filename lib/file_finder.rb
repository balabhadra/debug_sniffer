class FileFinder
  require 'yaml'

  def initialize(engine_config)
    @engine_config = engine_config
    file_config = YAML.load_file("../config/config.yml")
    @relevant_type = file_config['debug_sniffer']['extensions'].keys
  end

  def files
    Dir.chdir(args)
    files = []
    @relevant_type.each do |file_type|
      files += Dir.glob("**/*#{file_type}")
    end
    exclude_files(files)
  end

  private
  def exclude_files(files)
    exclusions = @engine_config['exclude_paths'] || []
    files.reject { |f| exclusions.include?(f) }
  end
end
