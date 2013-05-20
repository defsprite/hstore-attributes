# HstoreAttributes

[![Code Climate](https://codeclimate.com/github/defsprite/hstore-attributes.png)]


HstoreAttributes is a small extension on top of `activerecord-postgres-hstore`, which creates "fake" attributes that map into the hstore hash. By defining these attributes you get automatic validations and type casting.
The approach is very similar to the `ActiveRecord::Store` feature, yielding better query and index performance in comparison to simple hash-to-yml-string usage.


A small example:
```ruby
class Product < ActiveRecord::Base

  # serialize as hstore (not needed for activerecord-postgres-hstore < 0.7)
  serialize :properties, ActiveRecord::Coders::Hstore

  # define attributes with types to be mapped into the hstore
  hstore :properties, :accessors => { :width => :integer, :height => :integer, :color => :string }

  # if you want to dump strings only:
  hstore :properties, :accessors => [:color, :other_property, :third_property]

  validates_numericality_of :weight

  #  ...
end
```
## Installation

Add this line to your application's Gemfile:

    gem 'hstore-attributes'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install hstore-attributes

## Usage

Usage should be pretty straightforward as shown in the example. Be sure to create a hstore column that takes the mapped attributes. Please note that this works for postgresql databases only.

See: https://github.com/softa/activerecord-postgres-hstore

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
