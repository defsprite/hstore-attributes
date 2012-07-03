require File.expand_path(File.dirname(__FILE__) + '/test_helper')



class EmptyDbTest < MiniTest::Unit::TestCase

  def setup
    @connection = ActiveRecord::Base.connection
  end

  describe "the hstore attribute mapper" do

    it "should not break without a dabase table" do
      assert_silent do

        class HstoreModel < ActiveRecord::Base
          hstore :data, accessors: {:color => :string, :homepage => :string, :available_on => :date}
        end

      end

    end

  end

end
