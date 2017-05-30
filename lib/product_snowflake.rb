# encoding: utf-8

module ProductSnowflake
  extend ActiveSupport::Autoload

  class ModelTypeOutRangeError < StandardError; end
  class ModelSubTypeOutRangeError < StandardError; end
  class TimeMoveBackWardError < StandardError; end
  class TimeZeroError < StandardError; end

  autoload :CommonFactory
  autoload :CommonElements

  eager_autoload do
    autoload :SnowflakeFactory
    autoload :SnowflakeId
  end

  def self.eager_load!
    super
  end

end
