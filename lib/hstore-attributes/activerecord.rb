# Extends AR to add meta-columns for easy Hstore usage.
module ActiveRecord

  class Base
    include HstoreColumns

  end
end
