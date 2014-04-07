require 'active_support/concern'

module HstoreColumns
  extend ActiveSupport::Concern


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



  module ClassMethods

    def hstore_accessor(hstore_column, attr_name, type = :string)
      return unless table_exists?
      access_code                 = "(v=read_hstore('#{attr_name}', '#{hstore_column}')) && #{type_cast_code('v', type)}"

      class_eval <<-RUBY, __FILE__, __LINE__ + 1
            def #{attr_name}; #{access_code}; end
            def #{attr_name}= value; write_hstore('#{attr_name}', value, '#{hstore_column}'); end
      RUBY
      if type == :boolean
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{attr_name}?; #{attr_name}; end
        RUBY
      end
    end

    def hstore(store_attribute, options = {})
      accessors = options[:accessors]
      accessors.each do |key, value|
        hstore_accessor store_attribute, key, value.nil? ? :string : value
      end
    end

    def type_cast_code(var_name, type)
      klass = ActiveRecord::ConnectionAdapters::Column

      case type.to_sym
      when :string, :text        then var_name
      when :integer              then "(#{var_name}.to_i rescue #{var_name} ? 1 : 0)"
      when :float                then "#{var_name}.to_f"
      when :decimal              then "#{klass}.value_to_decimal(#{var_name})"
      when :datetime, :timestamp then "#{klass}.string_to_time(#{var_name})"
      when :time                 then "#{klass}.string_to_dummy_time(#{var_name})"
      when :date                 then "#{klass}.string_to_date(#{var_name})"
      when :binary               then "#{klass}.binary_to_string(#{var_name})"
      when :boolean              then "#{klass}.value_to_boolean(#{var_name})"
      else var_name
      end
    end

  end

end
