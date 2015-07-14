gemrc_file '/root/.gemrc' do
  options node['gemrc']['config']
end.run_action(:create)

ruby_block 'reload-gem-configuration' do
  block { Gem.configuration = Gem::ConfigFile.new ['--config-file=/root/.gemrc'] }
  only_if { node['gemrc']['reload'] }
end.run_action(:run)
