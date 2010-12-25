require 'fileutils'

module Grab
  class FileSaver

    def initialize(dest_dir)
      @directory = dest_dir
      create_directory!
    end

    def save(url, data)
      filename = File.join(@directory, File.basename(url))
      save_file(filename, data)
    end

    private

      def create_directory!
        return if File.exists?(@directory)
        FileUtils.mkdir_p(@directory)
      end

      def save_file(filename, data)
        File.open(filename, 'w+') {|f| f.write(data) }
      end

  end
end
