#!/usr/bin/rubys
# class DebugSniffer
#   def initialize
#     args = ARGV
#     @file_finder = FileFinder.new
#     @file_finder.relevant_files(args)
#   end
# end



require 'pry'
require 'yaml'

class FileFinder
  def initialize
    binding.pry
    file_config = YAML.load_file("../config/dictionay.yml")
    @relevant_type =  file_config['Sniffer']['include']['file_type'].keys
    binding.pry
  end



  # def relevant_files(args)
  #
  #   files
  # end
  #
  # def
  #   exclusions = @engine_config['exclude_paths'] || []
  #   final_files = files.reject { |f| exclusions.include?(f) }
  #   `csslint --format=checkstyle-xml #{final_files.join(" ")}`
  # end

  def files(args = ARGV)
    binding.pry
    files = []
    @relevant_type.each do |file_type|
      files += Dir.glob("**/*#{file_type}")
    end
  end
end


FileFinder.new
