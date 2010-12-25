require 'typhoeus'

module Grab
  class Downloader

    def initialize(file_saver)
      @file_saver = file_saver
      @urls = []
    end

    def add_url(url)
      @urls << url
    end

    def add_urls(urls)
      @urls |= urls
    end

    def run
      @urls.each do |url|
        request = Typhoeus::Request.new(url)
        request.on_complete {|response| save_file(url, response.body) }
        hydra.queue(request)
      end

      hydra.run
    end

    def hydra
      @hydra ||= Typhoeus::Hydra.new
    end

    private

      def save_file(url, data)
        @file_saver.save(url, data)
      end

  end
end
