require 'bundler/setup'
require 'active_record'

# explicitly require beforehand - activerecord-postgres-hstore is mostly monkeypatched.
require 'active_record/connection_adapters/postgresql_adapter'
require 'activerecord-postgres-hstore'

require 'minitest/autorun'
require File.expand_path('../lib/hstore-attributes', File.dirname(__FILE__))

require 'yaml'

config_file = File.expand_path('test-config.yml', File.dirname(__FILE__))

if File.exists?(config_file)
  config = YAML::load(File.open(config_file))
else
  config = {:adapter => 'postgresql', :database => 'hstore_test', :user => 'postgres', :password => ''}
  puts <<-MSG
=======================================================================================================================
Using default test DB config: #{config.inspect}
Please see test/test-config.yml.example if you want use a different config
=======================================================================================================================
  MSG
end

ActiveRecord::Base.establish_connection(config)
