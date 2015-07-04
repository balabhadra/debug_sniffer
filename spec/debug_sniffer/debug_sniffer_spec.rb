require 'debug_sniffer/debug_sniffer'
require 'pry'

module DebugSniffer
  RSpec.describe DebugSniffer do
    describe '#initialize' do


      it 'should initialize instance variables' do
        FileFinder.should_receive(:new).and_return file_finder_object
        file_finder = FileFinder.new(engine_config)
        binding.pry
        DebugSniffer.new(tmpdir = Dir.mktmpdir, engine_config='')
        binding.pry
      end
    end

    describe '#run' do
      it 'should invoke parser for each file'
    end
  end
end
