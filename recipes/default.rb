gemrc_file '/root/.gemrc'

ruby_block 'reload-gem-configuration' do
  block { Gem.configuration = Gem::ConfigFile.new ['/root/.gemrc'] }
  only_if { node['gemrc']['reload'] }
end
