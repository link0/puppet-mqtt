require 'bundler/setup'
require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |config|
  config.before :each do
    # Ensure that we don't accidentally cache facts and environment
    # between test cases.
    Facter.clear
    Facter.clear_messages
  end
  config.hiera_config = 'spec/fixtures/hiera/hiera.yaml'
end