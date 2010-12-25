require 'spec_helper'

require 'tmpdir'

describe "Grab" do

  let(:path_to_script) { File.expand_path(File.dirname(__FILE__) + '/../../grab.rb') }

  it "grabs logo.png from yandex" do
    Dir.mktmpdir do |tmp_dir|
      system(%{ruby #{path_to_script} "http://www.yandex.ru" #{tmp_dir}})
      path_to_file = File.join(tmp_dir, 'logo.png')

      File.exists?(path_to_file).should be_true
      File.size(path_to_file).should > 0
    end
  end

end