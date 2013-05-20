require 'test_helper'

class EmptyDbTest < MiniTest::Spec

  describe "the hstore attribute mapper" do

    it "should not break without a database table" do
      assert_silent do

        class OtherHstoreModel < ActiveRecord::Base
          serialize :data, ActiveRecord::Coders::Hstore

          hstore :data, :accessors => {:color => :string, :homepage => :string, :available_on => :date}
        end

      end

    end

  end

end
