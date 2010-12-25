require 'image_source'
require 'file_saver'
require 'downloader'

module Grab
  class Grabber

    def initialize(source, downloader)
      @source = source
      @downloader = downloader
    end

    def run
      @downloader.add_urls(@source.image_urls)
      @downloader.run
    end

  end
end