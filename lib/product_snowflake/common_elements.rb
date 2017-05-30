require 'active_support/concern'
module ProductSnowflake
  module CommonElements
    extend ActiveSupport::Concern
    # included do
    included do
      # extend ClassMethods
      init_id_columns
    end

    # extend ActiveSupport::Concern
    module ClassMethods
      # timestampe + model_type + model_sub_type + sequence
      #   41bit         4bit          4bit          8bit

      def init_id_columns
        add_id_bits :timestamp, 41  # ((Time.now.to_f*1000).to_i).bit_length
        add_id_bits :model_type, 4 # 模型类型，product
        add_id_bits :model_sub_type, 4
        add_id_bits :sequence, 8 #
        # add_id_bits :position, 4
      end

      # 定义同名的方法
      def add_id_bits(id, bit)
        class_eval <<-RUBY, __FILE__, __LINE__ + 1

          def #{id}=(value)
            @#{id} = value
          end

          def #{id}
            # 从配置获取得属性
            @#{id}
          end

          def #{id}_bits
            #{bit}
          end

          def self.#{id}_bits
            #{bit}
          end

          def max_#{id}_id
            -1 ^ -1 << #{bit}
          end

          def self.max_#{id}_id
            -1 ^ -1 << #{bit}
          end

        RUBY
      end
    end
  end
end
