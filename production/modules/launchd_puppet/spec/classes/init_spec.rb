require 'spec_helper'
describe 'launchd_puppet' do
  context 'with default values for all parameters' do
    it { should contain_class('launchd_puppet') }
  end
end
