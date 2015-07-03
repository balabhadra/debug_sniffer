class DebugSniffer
  def initialize(directory, engine_config, io)
    @file_finder = FileFinder.new(engine_config)
    @files = @file_finder.relevant_files(directory)
    @parser = Parser.new
  end

  def run
    @files.each do |file|
      result = []
      result << @parser.parse(file)
    end
    result
  end
end







