require File.expand_path(File.dirname(__FILE__) + '/test_helper')

class HstoreModel < ActiveRecord::Base
  hstore :data, accessors: {:color => :string, :homepage => :string, :available_on => :date}
  hstore :data, accessors: [:other_color, :other_homepage]

  hstore :data, accessors: {:string_test => :string, :date_test => :date, :datetime_test => :datetime, :integer_test => :integer}

end

class HstoreTest < MiniTest::Unit::TestCase

  def setup
    @connection = ActiveRecord::Base.connection
    puts @connection.native_database_types

    begin
      @connection.execute 'drop table if exists hstore_models'
      @connection.transaction do
        @connection.create_table('hstore_models') do |t|
          t.string :name
          t.hstore :data, :default => ''
        end
      end

    rescue ActiveRecord::StatementInvalid => e
      skip "ActiveRecord::StatementInvalid during table setup. Is your DB hstore capable at all? Error was: #{e}"
    rescue NoMethodError => e
      skip "NoMethodError during table setup. Is your DB hstore capable at all? Error was: #{e}"
    end
  end

  def teardown
    @connection.execute 'drop table if exists hstore_models'
  end

  describe "the hstore attribute mapper" do

    before do
      @record = HstoreModel.create(:name => 'John Doe')
    end

    after do
      HstoreModel.delete_all
    end

    it "should have the right column type" do
      column = HstoreModel.columns.find { |c| c.name == 'data' }
      assert_equal :hstore, column.type
    end

    it "should read attributes through accessors" do
      assert_equal 'John Doe', @record.name
      assert_nil @record.string_test
      assert_nil @record.date_test
      assert_nil @record.datetime_test
      assert_nil @record.integer_test
    end

    it "should write attributes through accessors" do
      datetime = Time.parse(Time.now.to_s) # why? see http://blog.kyleshipley.com/post/9415090497/a-ruby-time-idiosyncrasy
      date     = datetime.to_date

      @record.string_test   = 'red'
      @record.integer_test  = 42
      @record.date_test     = date
      @record.datetime_test = datetime

      assert_equal 'red', @record.string_test
      assert_equal 42, @record.integer_test
      assert_equal datetime, @record.datetime_test
      assert_equal date, @record.date_test

    end

    it "should restore old types after persisting" do
      datetime = Time.parse(Time.now.to_s)
      date     = datetime.to_date

      @record.string_test   = 'red'
      @record.integer_test  = 42
      @record.date_test     = date
      @record.datetime_test = datetime

      @record.save
      @record.reload

      assert_equal 'red', @record.string_test
      assert_equal 42, @record.integer_test
      assert_equal datetime, @record.datetime_test
      assert_equal date, @record.date_test
    end

    it "should write hstore data directly" do

      @record.data = {'icecream' => 'graeters'}
      @record.save
      assert_equal({'icecream' => 'graeters'}, @record.reload.data)
    end


    it "should update the store and mark it as changed" do
      @record.string_test = 'blue'
      assert @record.data_changed?
    end

    it "should assign data assigned via new or create" do
      @record = HstoreModel.new(:string_test => "Dame Edna")
      assert_equal "Dame Edna", @record.string_test
    end

  end

end
