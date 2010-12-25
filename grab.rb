require "bundler/setup"
require "open-uri"

$: << File.join(File.dirname(__FILE__), 'lib')

require 'grabber'

page_url, dest_folder= ARGV

include Grab

source = ImageSource.new(page_url)
downloader = Downloader.new(FileSaver.new(dest_folder))

Grabber.new(source, downloader).run