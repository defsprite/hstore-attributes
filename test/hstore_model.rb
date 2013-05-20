class HstoreModel < ActiveRecord::Base
  serialize :data, ActiveRecord::Coders::Hstore

  hstore :data, :accessors => {:color => :string, :homepage => :string, :available_on => :date}
  hstore :data, :accessors => [:other_color, :other_homepage]

  hstore :data, :accessors => {:string_test => :string, :date_test => :date, :datetime_test => :datetime, :integer_test => :integer}
end
