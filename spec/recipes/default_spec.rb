require 'chefspec'

describe 'gemrc::default' do
  let(:chef_run) { ChefSpec::ChefRunner.new('..').converge 'gemrc::default' }

  it { chef_run.should create_file '/root/.gemrc' }
end
