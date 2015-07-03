require 'debug_sniffer/parser_interface'
module DebugSniffer
  class JsParser < ParserInterface
    attr_accessor :file

    def initialize(file)
      @file = file
      @terms = %w(console.log alert debugger)
    end

    def parse
      issues = []
      File.open(@file).each_with_index do |line, index|
        @terms.each do |term|
          if line =~ /#{term}/
            issues << {type: "issue", check_name: "Debug codes", description: "Js debug code detected", categories: ["Clarity", "Style"], location: {path: @file, lines: {begin: index, end: index}}, remediation_points: 500}
            break
          end
        end
      end
      issues
    end
  end
end
