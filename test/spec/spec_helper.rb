require 'chefspec'
require 'chefspec/policyfile'

RSpec.configure do |config|
  config.platform = 'ubuntu'
  config.version = '14.04'
end
