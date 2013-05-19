require 'test_helper'

class EmptyDbTest < MiniTest::Unit::TestCase

  def setup
    @connection = ActiveRecord::Base.connection
    @connection.execute 'drop table if exists hstore_models'
  end

  describe "the hstore attribute mapper" do

    it "should not break without a database table" do
      assert_silent do

        class OtherHstoreModel < ActiveRecord::Base
          hstore :data, accessors: {:color => :string, :homepage => :string, :available_on => :date}
        end

      end

    end

  end

end
