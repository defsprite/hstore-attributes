require 'bundler/setup'
require 'active_record'

# explicitly require beforehand - activerecord-postgres-hstore is mostly monkeypatched.
require 'active_record/connection_adapters/postgresql_adapter'
require 'activerecord-postgres-hstore'

require 'minitest/autorun'
require File.expand_path('../lib/hstore-attributes', File.dirname(__FILE__))

require 'yaml'
ActiveRecord::Base.establish_connection(YAML::load(File.open(File.expand_path('config.yml', File.dirname(__FILE__)))))
