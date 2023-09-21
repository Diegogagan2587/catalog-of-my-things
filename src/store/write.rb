require 'json'
require 'fileutils'

class Write
  def create_file(file_name)
    FileUtils.mkdir_p('../data') unless File.directory?("./data")
    FileUtils.touch("../data/#{file_name}") unless File.exist?("../data/#{file_name}")
  end
end