require 'chefspec'
require 'chefspec/berkshelf'

RSpec.configure do |config|
  config.platform = 'ubuntu'
  config.version = '14.04'
end

describe 'gemrc::default' do
  context 'with default attributes' do
    cached(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }
    it { expect(chef_run).to create_gemrc_file('/root/.gemrc') }
    it { expect(chef_run).not_to run_ruby_block('reload-gem-configuration') }
    it 'converges successfully' do
      chef_run
    end
  end

  context "with node['gemrc']['reload'] = true" do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.set['gemrc']['reload'] = true
      end.converge(described_recipe)
    end

    it { expect(chef_run).to create_gemrc_file('/root/.gemrc') }
    it { expect(chef_run).to run_ruby_block('reload-gem-configuration') }
    it 'converges successfully' do
      chef_run
    end
  end
end
