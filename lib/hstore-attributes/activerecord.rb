# Extends AR to add meta-columns for easy Hstore usage.
require 'hstore_columns'

module ActiveRecord

  module ConnectionAdapters

    class HstoreMetaColumn < Column
    end

  end

  class Base
    include HstoreColumns
  end
end
