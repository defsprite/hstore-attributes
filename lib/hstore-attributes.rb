require "active_support"

ActiveSupport.on_load :active_record do
  require "hstore-attributes/hstore_columns"
  require "hstore-attributes/activerecord"
end
