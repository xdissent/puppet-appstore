require 'spec_helper'

describe 'appstore' do

  let(:facts) { default_test_facts }

  it do
    should contain_file '/opt/boxen/appstore.app'
    should contain_exec 'appstore-accessibility'
  end
end