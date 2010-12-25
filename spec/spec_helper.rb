require 'rspec'
require 'ap'
require 'fakeweb'

$: << File.join(File.dirname(__FILE__), '/../lib')

RSpec.configure do |config|
  config.mock_with :rspec
end