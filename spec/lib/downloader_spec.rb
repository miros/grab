require 'spec_helper'

require 'downloader'

describe Grab::Downloader do

  let(:file_saver) { mock('saver') }
  let(:downloader) { Grab::Downloader.new(file_saver) }

  it "downloads given tasks" do
    add_task('http://www.test.ru/file.txt', 'file data')
    add_task('http://www.test.ru/other_file.txt', 'other file data')

    downloader.run
  end

  def add_task(url, data)
    stub_url(url, data)
    downloader.add_url(url)
    downloader.should_receive(:save_file).with(url, data)
  end

  def stub_url(url, body)
    response = Typhoeus::Response.new(:code => 200, :body => body)
    downloader.hydra.stub(:get, url).and_return(response)
  end

end