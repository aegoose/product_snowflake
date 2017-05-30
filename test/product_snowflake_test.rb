require 'test_helper'

class ProductSnowflake::Test < ActiveSupport::TestCase
  test "snowflake id test" do
    pid = ProductSnowflake::SnowflakeFactory.next_product_id

    puts "#{pid}"

  end
end
