require 'debug_sniffer/parser_interface'
require 'debug_sniffer/issue_detector'
require 'json'

module DebugSniffer

  # Ruby Parser to detect issues
  # @attr_reader :file [String]
  class RbParser < ParserInterface

    include IssueDetector

    attr_accessor :file

    DESCRIPTION = "Ruby debug code detected"

    # Constructor
    # @param file [String]
    def initialize(file)
      @file = file
      @terms = %w(binding.pry byebug puts)
    end

    # Invoke the dedicated issue detector
    # @return [Boolean]
    def parse
      detect_issue(DESCRIPTION)
    end

  end
end
