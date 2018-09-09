
module CustomLogging
  COLOR_ESCAPES = { ERROR: 31, DEBUG: 32, INFO: 34 }
  class DefaultFormatter <  Logger::Formatter
    def call(severity, time, progname, msg)
      "\x1B[" + ( COLOR_ESCAPES[severity.to_sym] || 0 ).to_s + 'm'"[#{time.strftime('%Y-%m-%d %H:%M:%S')}]#{severity} [#{progname}] : #{msg}\n"
    end
  end
end
