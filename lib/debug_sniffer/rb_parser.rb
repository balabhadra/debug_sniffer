require 'debug_sniffer/parser_interface'
require 'debug_sniffer/issue_detector'
require 'json'

module DebugSniffer
  class RbParser < ParserInterface

    include IssueDetector
    
    attr_accessor :file
    
    DESCRIPTION = "Ruby debug code detected"

    def initialize(file)
      @file = file
      @terms = %w(binding.pry byebug puts)
    end

    def parse
      detect_issue(DESCRIPTION)
    end
    
  end
end
