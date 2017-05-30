require 'active_support/concern'

module ProductSnowflake
  class SnowflakeFactory
    include CommonFactory

    @@instance = SnowflakeFactory.new

    def self.next_product_id
      @@instance.next_product_id
    end

    def self.next_user_id
      @@instance.next_user_id
    end

    def self.next_sku_id
      @@instance.next_sku_id
    end

    def self.next_spu_id
      @@instance.next_spu_id
    end

    def self.next_product_image
      @@instance.next_product_image
    end

    private_class_method :new

  end
end
