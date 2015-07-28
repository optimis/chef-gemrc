require 'poise'
require 'rubygems/config_file'

module GemrcCookbook
  class GemrcFile < Chef::Resource
    include Poise(fused: true)
    provides(:gemrc_file)

    attribute(:path, kind_of: String, name_attribute: true)
    attribute(:owner, kind_of: [NilClass, String], default: nil)
    attribute(:group, kind_of: [NilClass, String], default: nil)
    attribute(:mode, kind_of: String, default: '0644')
    attribute(:options, option_collector: true, default: { gem: '--no-ri --no-rdoc' })

    def to_yaml
      config = {}
      symbols = %i{sources update_sources backtrace verbose bulk_threshold}
      options.each_pair do |k, v|
        if symbols.include?(k.to_sym)
          config[k.to_sym] = v
        else
          config[k] = v
        end
      end
      config.to_yaml
    end

    action(:create) do
      notifying_block do
        directory ::File.dirname(new_resource.path)

        file new_resource.path do
          content new_resource.to_yaml
          owner new_resource.owner
          group new_resource.group
          mode new_resource.mode
        end
      end
    end

    action(:delete) do
      notifying_block do
        file new_resource.path do
          action :delete
        end
      end
    end
  end
end
