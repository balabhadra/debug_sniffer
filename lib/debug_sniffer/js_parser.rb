require 'debug_sniffer/parser_interface'
require 'debug_sniffer/issue_detector'
require 'json'

module DebugSniffer
  # Javascript Parser to detect issues
  # @attr_reader :file [String]
  class JsParser < ParserInterface

    include IssueDetector

    attr_accessor :file

    DESCRIPTION = "JS debug code detected"

    # Constructor
    # @param file [String]
    def initialize(file)
      @file = file
      @terms = %w(console.log alert debugger)
    end

    # Invoke the dedicated issue detector
    # @return [Boolean]
    def parse
      detect_issue(DESCRIPTION)
    end

  end
end
