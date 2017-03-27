require 'poise_boiler/spec_helper'
require_relative '../../../libraries/gemrc_file'

describe GemrcCookbook::GemrcFile do
  step_into(:gemrc_file)
  context '#action_create' do
    recipe { gemrc_file '/root/.gemrc' }
    it { is_expected.to create_file('/root/.gemrc') }
  end

  context '#action_delete' do
    recipe do
      gemrc_file '/root/.gemrc' do
        action :delete
      end
    end

    it { is_expected.to delete_file('/root/.gemrc') }
  end
end
