require 'debug_sniffer/file_finder'
require "tmpdir"

module DebugSniffer
  RSpec.describe FileFinder do

    before(:all) {@dir = Dir.mktmpdir}

    describe '#new' do
      before(:all) {@file_finder = FileFinder.new({"exclude_paths"=>[]})}
      it "should have non-nil engine config" do
        expect(@file_finder.engine_config).to be_truthy
      end
      it "should have relevant keys defined in config" do
        expect(@file_finder.relevant_type).to eql(['rb','js','erb'])
      end
    end

    describe ".files" do
      context 'When there is exclude files' do
        it 'should return no files' do
          @file_finder = FileFinder.new( {"exclude_paths"=>["foo.rb"]})
          create_source_file("foo.rb", <<-EORUBY)
          def test
            binding.pry
            1+2
            puts 'hello'
          end
          EORUBY

          expect(@file_finder.files(@dir)).to eql([])
        end
      end

      context 'When there is unrelated exclude files' do
        it 'should return foo.rb file' do
          @file_finder = FileFinder.new( {"exclude_paths"=>["foos.rb"]})
          create_source_file("foo.rb", <<-EORUBY)
          def test
            binding.pry
            1+2
            puts 'hello'
          end
          EORUBY

          expect(@file_finder.files(@dir)).to eql(["foo.rb"])
        end

        context 'When there is no exclude files' do
          it 'should return foo.rb file' do
            @file_finder = FileFinder.new( {"exclude_paths"=>nil})
            create_source_file("foo.rb", <<-EORUBY)
            def test
              binding.pry
              1+2
              puts 'hello'
            end
            EORUBY

            expect(@file_finder.files(@dir)).to eql(["foo.rb"])
          end
        end

      end

      def create_source_file(path, content)
        File.write(File.join(@dir, path), content)
      end
    end
  end
end
