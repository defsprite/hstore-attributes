module HstoreColumns
  extend ActiveSupport::Concern


  module InstanceMethods
    
    def read_hstore(key, hstore_column)
      new_value = send(hstore_column) || {}
      new_value.fetch(key.to_s, nil)
    end

    def write_hstore(key, value, hstore_column)
      new_value = send(hstore_column) || {}
      new_value.store(key.to_s, value)
      send("#{hstore_column}=", new_value)
      send("#{hstore_column}_will_change!")
    end
 
  end

  module ClassMethods
    
    def hstore_attribute(hstore_column, attr_name, type)
      column                      = ActiveRecord::ConnectionAdapters::HstoreMetaColumn.new(attr_name, nil, "#{type}")
      columns_hash[attr_name.to_s]= column
      cast_code                   = column.type_cast_code('v')
      access_code                 = "(v=read_hstore('#{attr_name}', '#{hstore_column}')) && #{cast_code}"
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
            def #{attr_name}; #{access_code}; end
            def #{attr_name}= value; write_hstore('#{attr_name}', '#{hstore_column}', value); end
      RUBY
    end

    def hstore_attributes(hstore_column, type = :string, *attrs)
      attrs.each { |attr| hstore_attribute hstore_column, attr, type.to_sym }
    end

  end

end
