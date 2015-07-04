require 'debug_sniffer/parser_interface'
require 'debug_sniffer/issue_detector'
require 'json'

module DebugSniffer
  
  class JsParser < ParserInterface
    
    include IssueDetector
    
    attr_accessor :file

    DESCRIPTION = "JS debug code detected"

    def initialize(file)
      @file = file
      @terms = %w(console.log alert debugger)
    end

    def parse
      detect_issue(DESCRIPTION)
    end
    
  end
end
