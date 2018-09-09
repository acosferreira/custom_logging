require 'socket'
require 'logger'
require 'logging'
require 'custom_logging'
require 'custom_logging/default_formatter'
require 'custom_logging/default_logger'

module CustomLogging
  extend self
  def logger(config)
    logger = CustomLogging::DefaultLogger.new(config)
    return logger.multi_logger(config) if config[:config][:output] == 'BOTH'
    return logger.hierarchical if !config[:config][:has_parent].nil?
    logger
  end
end
