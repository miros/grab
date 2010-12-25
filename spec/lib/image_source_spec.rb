require 'spec_helper'

require 'image_source'

describe Grab::ImageSource do

  FakeWeb.allow_net_connect = false

  describe ".image_urls" do

    let(:url) { "http://test.ru/test/test.html" }

    it "returns urls of images presented in page" do
      stub_url(url, %{text text <img src="http://host.com/image.jpg" /> text text})
      images(url).should == ["http://host.com/image.jpg"]
    end

    context "with image src given as relative url" do
      it "expands relative urls to absolute" do
        stub_url(url, image_tag("/image.jpg"))
        images(url).should == ["http://test.ru/image.jpg"]
      end
    end

    context "with image src given as single filename" do
      it "expands filenames to absolute urls" do
        stub_url(url, image_tag("image.jpg"))
        images(url).should == ["http://test.ru/test/image.jpg"]
      end
    end

    def images(url)
      Grab::ImageSource.new(url).image_urls
    end

    def image_tag(src)
      %{<img src="#{src}" />}
    end

  end

  def stub_url(url, body)
    FakeWeb.register_uri(:any, url, :body => body)
  end

end