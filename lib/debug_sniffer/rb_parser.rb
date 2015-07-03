require 'debug_sniffer/parser_interface'
require 'json'
module DebugSniffer
  class RbParser < ParserInterface

    attr_accessor :file

    def initialize(file)
      @file = file
      @terms = %w(binding.pry byebug debugger puts)
    end

    def parse
      File.open(@file).each_with_index do |line, index|
        @terms.each do |term|
          if line =~ /#{term}/
            issue = {"type"=> "issue", "check_name" => "Debug codes", "description" => "Ruby debug code detected", "categories" => ["Clarity", "Style"], "location" => {"path" => @file, "lines" => {"begin"  => index, "end" => index}}, "remediation_points" => 500}
            STDOUT.print "#{issue.to_json}\0"
            break
          end
        end
      end
    end
  end
end
