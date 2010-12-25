require 'spec_helper'

require 'downloader'

describe Grab::FileSaver do

  it "creates destination directory if it does not exist" do
    dir = '/path/to/dir'

    File.stub(:exists?) { false }
    FileUtils.should_receive(:mkdir_p).with(dir)

    Grab::FileSaver.new(dir)
  end

  it "saves given data to correct destination" do
    dir = Dir.tmpdir

    grabber = Grab::FileSaver.new(dir)
    grabber.save('http://test.ru/images/test_file_name.txt', 'test file data')

    File.read(File.join(dir, 'test_file_name.txt')).should == "test file data"
  end


end