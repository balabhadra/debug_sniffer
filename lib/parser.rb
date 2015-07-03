class Parser

  def initialize
    @file_config = YAML.load_file("../config/config.yml")
    @keys = @file_config['debug_sniffer']['extensions'].keys
    @parser_hash = @keys.inject({}) do |val, key|
      val.merge!(key => @file_config['debug_sniffer']['extensions'][key]['parser'])
    end
  end

  def parse(file)
    extension =File.extname(file)
    camelized_parsers = @parser_hash[extension].map { |parser| camelize(parser) }
    parser_response = []
    camelized_parsers.each do |camelized_parser|
      parser_response << eval(camelized_parser).new(file).parse
    end
    parser_response
  end

  private

  def camelize(str)
    str.split('_').map { |w| w.capitalize }.join
  end

end
