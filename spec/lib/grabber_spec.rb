require 'spec_helper'

require 'grabber'

describe Grab::Grabber do

  let(:source) { mock('image source') }
  let(:downloader) { mock('downloader') }

  let(:grabber) { Grab::Grabber.new(source, downloader) }

  it "coordinates images grabbing" do

    image_urls = stub
    source.stub(:image_urls) { image_urls }
    downloader.should_receive(:add_urls).with(image_urls)

    downloader.should_receive(:run)

    grabber.run
  end

end