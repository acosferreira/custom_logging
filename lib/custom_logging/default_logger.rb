module CustomLogging
  class DefaultLogger <  Logger

    attr_accessor :config

    def initialize(config:{})
      config[:formatter] = config[:formatter] ||= DefaultFormatter.new
      config[:service_name] = config[:service_name] ||= ''
      config[:output] = config[:output] || create_default_output

      @config = config
      super(config[:output])
      setup!
    end

    def create_default_output
      STDOUT
    end

    def multi_logger(config:{})
      time = Time.now.strftime('%Y-%m-%d %H:%M:%S')
      logger = Logging.logger["[#{time}][#{config[:service_name]}]"]
      logger.add_appenders \
          Logging.appenders.stdout,
          Logging.appenders.file("#{config[:filename]}.log")

    end

    def hierarchical
      root = Logging.logger["#{config[:has_parent]}"]
      child = Logging.logger["#{config[:has_parent]}::#{config[:service_name]}"]
      root.appenders = Logging.appenders.file("#{config[:filename]}.log")
      child
    end

    private

    def setup!

      self.progname = config[:service_name]
      set_formatter
    end


    def set_formatter
      self.formatter = proc { |severity, datetime, progname, msg|
        msg = msg.join(", ") if msg.is_a? Enumerable
        config[:formatter].call(severity, datetime, progname, msg.dump)
      }
    end
  end
end
