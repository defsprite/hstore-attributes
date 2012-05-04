# HstoreAttributes

Hstore Attributes is a small extension on top of `activerecord-postgres-hstore`, which creates "fake" attributes that map into the hstore hash. By defining these attributes you get automatic validations and type casting.
A small example:

    class Product < ActiveRecord::Base
      # hstore column is named 'properties'
      hstore_attributes :properties, :integer, :width, :height, :depth, :weight
      hstore_attribute :properties, :date, :revision_date
      
      validates_numericality_of :weight
      
      #  ...
    end

## Installation

Add this line to your application's Gemfile:

    gem 'hstore-attributes'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hstore-attributes

## Usage

Usage should be pretty straightforward as shown in the example. Be sure to create a hstore column that takes the mapped attributes.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
