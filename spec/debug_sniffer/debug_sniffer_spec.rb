require 'debug_sniffer/debug_sniffer'
require "tmpdir"

module DebugSniffer
  RSpec.describe DebugSniffer do
    
    before(:all) {@dir = Dir.mktmpdir}
    before(:all) {@sniffer = DebugSniffer.new(@dir, {"exclude_paths"=>[]}) }

    describe '#new' do
      it "should have non-nil directory" do
        expect(@sniffer.directory).to be_truthy 
      end
      it "should have non-nil engine config" do
        expect(@sniffer.engine_config).to be_truthy
      end
    end

    describe '.run' do
      it 'should invoke parser for each file' do
        create_source_file("foo.rb", <<-EORUBY)
        def test
          binding.pry
          1+2
          puts 'hello'
        end
        EORUBY
        
        $stdout = StringIO.new
        @sniffer.run
        expect($stdout.string).to include('"begin":2')
        expect($stdout.string).to include('"begin":4')        
      end
    end

    def create_source_file(path, content)
      File.write(File.join(@sniffer.directory, path), content)
    end
  end
end
