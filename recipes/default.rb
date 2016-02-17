#
# Cookbook: gemrc
# License: Apache 2.0
#
# Copyright 2015-2016, Bloomberg Finance L.P.
#
arguments = ['--config-file', node['gemrc']['path']].join('=')
ruby_block 'reload-gem-configuration' do
  action :nothing
  block { Gem.configuration = Gem::ConfigFile.new [arguments] }
  only_if { node['gemrc']['reload'] }
end

gemrc_file node['gemrc']['path'] do
  options node['gemrc']['config']
  notifies :run, 'ruby_block[reload-gem-configuration]', :delayed
end.run_action(:create)
