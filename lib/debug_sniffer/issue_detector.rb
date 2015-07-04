module DebugSniffer
  module IssueDetector
    
    def detect_issue(description)
      File.open(@file).each.with_index(1) do |line, index|
        @terms.each do |term|
          if line =~ /#{term}/
            issue = {"type"=> "issue", "check_name" => "Debug codes", "description" => description, "categories" => ["Clarity", "Style"], "location" => {"path" => @file, "lines" => {"begin"  => index}}, "remediation_points" => 500}
            STDOUT.print "#{issue.to_json}\0"
            break
          end
        end
      end
    end
     
  end
end