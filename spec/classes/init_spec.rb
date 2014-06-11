require 'spec_helper'
describe 'opensprinkler_pi' do

  context 'with defaults for all parameters' do
    it { should contain_class('opensprinkler_pi') }
  end
end
