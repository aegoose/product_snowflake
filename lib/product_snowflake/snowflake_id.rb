require 'monitor'

module ProductSnowflake

  class SnowflakeId
    include CommonElements

    # timestampe + model_type + model_sub_type + sequence
    #   41bit         4bit          4bit          8bit

    # 基准时间
    BASE_TIMESTAMP = 1483200000000
    # (Time.parse("2017-01-01T00:00:00.000").to_f*1000).to_i

    # 类型编码
    MODEL_SUB_TYPE_ID_LEFT_SHIFT = sequence_bits

    # 子类型编码
    MODEL_TYPE_ID_LEFT_SHIFT = MODEL_SUB_TYPE_ID_LEFT_SHIFT + model_type_bits

    # 时间毫秒左移23位
    TIMESTAMP_LEFT_SHIFT = MODEL_TYPE_ID_LEFT_SHIFT + model_sub_type_bits

    attr_reader :model_type, :model_sub_type, :curr_timestamp, :sequence

    def self.parseSnowflakeId(snowflakeId)
      o = allocate
      o.parseSnowflakeId(snowflakeId)
      o
    end

    ## 分解编号
    def parseSnowflakeId(snowflakeId)

      curr_span = snowflakeId >> TIMESTAMP_LEFT_SHIFT
      seq = snowflakeId & max_sequence_id
      sub_ty = (snowflakeId >> MODEL_SUB_TYPE_ID_LEFT_SHIFT) & max_model_sub_type_id
      m_ty = (snowflakeId >> MODEL_TYPE_ID_LEFT_SHIFT) & max_model_type_id

      valid_range(m_ty, sub_ty)

      @curr_timestamp = curr_span +  BASE_TIMESTAMP
      @model_sub_type = sub_ty
      @model_type = m_ty
      @sequence = seq

      @lock = Monitor.new unless @lock.nil?

    end

    def initialize(m_type, m_sub_type)

      valid_range(m_type, m_sub_type)

      @model_type = m_type
      @model_sub_type = m_sub_type
      @lock = Monitor.new
      @last_timestamp = 0
      @sequence = 0
      @curr_timestamp = 0
    end

    ## 当前的
    def curr_id
      if @curr_timestamp <= 0
        raise TimeZeroError.new("Timestamp should no bee zero")
      end
      curr_span = @curr_timestamp - BASE_TIMESTAMP

      return (curr_span << TIMESTAMP_LEFT_SHIFT) | (model_type << MODEL_TYPE_ID_LEFT_SHIFT) | (model_sub_type << MODEL_SUB_TYPE_ID_LEFT_SHIFT) | sequence
    end

    def next_id
      @lock.synchronize do
        timestamp = new_timestamp

        if timestamp < @last_timestamp
          diff_milliseconds = last_timestamp - timestamp
          raise TimeMoveBackWardError.new("Refusing to generate id for #{ diff_milliseconds } milliseconds")
        end

        if timestamp == @last_timestamp
          @sequence = (sequence + 1) & max_sequence_id

          if sequence == 0
            timestamp = tail_next_timestamp(@last_timestamp)
          end
        else
          @sequence = rand(10)
        end

        @last_timestamp = timestamp
        @curr_timestamp =  timestamp
        return curr_id

      end
    end
    alias next next_id

    private
    def tail_next_timestamp(last_timestamp)
      timestamp = new_timestamp

      while (timestamp <= last_timestamp)
        timestamp = new_timestamp
      end

      return timestamp
    end

    private
    def new_timestamp
      (Time.now.to_f * 1000).to_i
    end

    private
    def valid_range(m_type, m_sub_type)
      if m_type < 0 || m_type > max_model_type_id
        raise ModelTypeOutRangeError.new
      end

      if m_sub_type < 0 || m_sub_type > max_model_sub_type_id
        raise ModelSubTypeOutRangeError.new
      end
    end
  end
end
