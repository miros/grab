require 'open-uri'
require 'nokogiri'
require "addressable/uri"

module Grab
  class ImageSource

    attr_reader :page_uri

    def initialize(url)
      @page_uri = Addressable::URI.heuristic_parse(url)
    end

    def image_urls
      page = Nokogiri::HTML(page_html)
      page.css("img").map {|img| make_url_absolute(img[:src])}.compact
    end

    private

      def make_url_absolute(url)
        begin
          img_uri = URI::parse(url)
        rescue URI::InvalidURIError
          return nil
        end

        return img_uri.to_s if img_uri.absolute?

        if url[0] == '/'
          page_uri.clone.tap {|new_uri| new_uri.path = url }
        else
          URI::parse(page_uri.to_s) + img_uri
        end.to_s
      end

      def page_html
        @page_html ||= open(page_uri).read
      end

  end
end