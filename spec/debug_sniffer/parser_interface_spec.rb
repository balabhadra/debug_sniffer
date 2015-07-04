require 'debug_sniffer/parser_interface'

module DebugSniffer
  RSpec.describe ParserInterface do
    let(:parser_interface) { ParserInterface.new }
    describe ".parse" do
      it 'should raise exception' do
        expect{parser_interface.parse}.to raise_exception
      end
    end
    describe ".build_issue" do
      it 'should raise exception' do
        expect{parser_interface.build_issue}.to raise_exception
      end
    end

  end
end