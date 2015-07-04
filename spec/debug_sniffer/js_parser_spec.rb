require 'debug_sniffer/js_parser'
require "tmpdir"

module DebugSniffer
  RSpec.describe JsParser do

    before(:all) do 
      @dir = Dir.mktmpdir
      file = File.write(File.join(@dir, "foo.js"), <<-EORUBY)
      function test()
        alert('hello');
        console.log('hello');
      end
      EORUBY
    @js_parser = JsParser.new(file)
    end

    describe "#new" do
      it "should have non-nil file" do
        expect(@js_parser.file).to be_truthy
      end
      it "should have non-nil terms" do
        expect(@js_parser.terms).to be_truthy 
      end
    end
  end
end