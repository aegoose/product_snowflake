# ProductSnowflake
snowflake id for product model.

## Usage
How to use my plugin.
```ruby
ProductSnowflake::SnowflakeFactory.next_product_id
ProductSnowflake::SnowflakeFactory.next_spu_id
ProductSnowflake::SnowflakeFactory.next_sku_id
ProductSnowflake::SnowflakeFactory.next_user_id
ProductSnowflake::SnowflakeFactory.next_product_id


s = Snowflake::SnowflakeId.parseSnowflakeId(848956444660228)
s.curr_id           # 848956444660228
s.model_type        # 5
s.model_sub_type    # 2
s.curr_timestamp    # 1496154047312
s.sequence          # 4

```

### Model type variables
```ruby

Snowflake::MODEL_TYPE_USER          # 1
Snowflake::MODEL_TYPE_CATEGORY      # 2
Snowflake::MODEL_TYPE_SK_TYPE       # 3
Snowflake::MODEL_TYPE_SK_VALUE      # 4
Snowflake::MODEL_TYPE_PRODUCT       # 5

Snowflake::MODEL_SUB_TYPE_NONE          # 0
Snowflake::MODEL_SUB_TYPE_PRODUCT_SKU   # 1
Snowflake::MODEL_SUB_TYPE_PRODUCT_SPU   # 2
Snowflake::MODEL_SUB_TYPE_PRODUCT_IMAGE # 3

```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'product_snowflake'
```


## Contributing
Contribution directions go here.

Reference with [https://github.com/villins/snowflake-rb](https://github.com/villins/snowflake-rb){target="_blank"}


## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
