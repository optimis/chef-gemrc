gemrc_file node['gemrc']['path'] do
  options node['gemrc']['config']
end.run_action(:create)

config_argument = ['--config-file', node['gemrc']['path']].join('=')

ruby_block 'reload-gem-configuration' do
  block { Gem.configuration = Gem::ConfigFile.new [config_argument] }
  only_if { node['gemrc']['reload'] }
end.run_action(:run)
