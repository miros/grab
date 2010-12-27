require 'spec_helper'

require 'tmpdir'

describe "Grab" do

  let(:path_to_script) { File.expand_path(File.dirname(__FILE__) + '/../../grab.rb') }

  it "grabs images from yandex" do
    Dir.mktmpdir do |tmp_dir|
      system(%{ruby #{path_to_script} "http://www.yandex.ru" #{tmp_dir}})
      path_to_file = File.join(tmp_dir, 'logo.png')

      Dir.glob(tmp_dir + '/*').count.should > 0
    end
  end

end