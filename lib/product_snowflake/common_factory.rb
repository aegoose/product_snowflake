module ProductSnowflake

  MODEL_TYPE_USER = 1
  MODEL_TYPE_CATEGORY = 2
  MODEL_TYPE_SK_TYPE = 3
  MODEL_TYPE_SK_VALUE = 4
  MODEL_TYPE_PRODUCT = 5

  MODEL_SUB_TYPE_NONE = 0
  MODEL_SUB_TYPE_PRODUCT_SKU =1
  MODEL_SUB_TYPE_PRODUCT_SPU = 2
  MODEL_SUB_TYPE_PRODUCT_IMAGE = 3

  module CommonFactory
    extend ActiveSupport::Concern

    included do
      init_variables
    end

    module ClassMethods
      # timestampe + model_type + model_sub_type + sequence
      #   41bit         4bit          4bit          8bit

      def init_variables
        add_read_variable :user_id, MODEL_TYPE_USER, MODEL_SUB_TYPE_NONE
        add_read_variable :category_id, MODEL_TYPE_CATEGORY, MODEL_SUB_TYPE_NONE
        add_read_variable :sk_type_id, MODEL_TYPE_SK_TYPE, MODEL_SUB_TYPE_NONE
        add_read_variable :sk_value_id, MODEL_TYPE_SK_VALUE, MODEL_SUB_TYPE_NONE
        add_read_variable :product_id, MODEL_TYPE_PRODUCT, MODEL_SUB_TYPE_NONE
        add_read_variable :sku_id, MODEL_TYPE_PRODUCT, MODEL_SUB_TYPE_PRODUCT_SKU
        add_read_variable :spu_id, MODEL_TYPE_PRODUCT, MODEL_SUB_TYPE_PRODUCT_SPU
        add_read_variable :product_image, MODEL_TYPE_PRODUCT, MODEL_SUB_TYPE_PRODUCT_IMAGE
      end

      # 定义同名的方法
      def add_read_variable(id, m_type, m_sub_type)
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{id}
            # 初始化
            if (not instance_variable_defined?(:@#{id})) || @#{id}.nil?
              @#{id} = ProductSnowflake::SnowflakeId.new(#{m_type}, #{m_sub_type})
            end
            # 输入值
            @#{id}
          end

          def next_#{id}
            #{id}.next
          end

        RUBY
      end

    end
  end
end
