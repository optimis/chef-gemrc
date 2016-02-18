require 'spec_helper'

describe 'gemrc::default' do
  context 'with default node attributes' do
    cached(:chef_run) do
      ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '14.04')converge('gemrc::default')
    end
    it { expect(chef_run).to create_gemrc_file('/root/.gemrc') }
    it { expect(chef_run).not_to run_ruby_block('reload-gem-configuration') }
  end

  context "with node['gemrc']['reload'] = true" do
    cached(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '14.04') do |node|
        node.set['gemrc']['reload'] = true
      end.converge('gemrc::default')
    end
    it { expect(chef_run).to create_gemrc_file('/root/.gemrc') }
    it { expect(chef_run).to run_ruby_block('reload-gem-configuration') }
  end
end
