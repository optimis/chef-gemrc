#
# Cookbook: gemrc
# License: Apache 2.0
#
# Copyright 2013, OptimisCorp, Inc.
# Copyright 2015-2017, Bloomberg Finance L.P.
#

ruby_block 'reload-gem-configuration' do
  action :nothing
  block do
    arguments = ['--config-file', node['gemrc']['path']].join('=')
    Gem.configuration = Gem::ConfigFile.new [arguments]
  end
  only_if { node['gemrc']['reload'] }
end

gemrc_file node['gemrc']['path'] do
  options node['gemrc']['config']
  notifies :run, 'ruby_block[reload-gem-configuration]', :immediately
end.run_action(:create)
