# CustomLogging
  This gem was build to improve a way to work with simple, hierarchical and multiple outputs logs.
  All level of output are enabled
## Installation

Add this line to your application's Gemfile:

```ruby
gem 'custom_logging'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install custom_logging

## Usage
Simple output
```
  output = CustomLogging.logger(config:{})
  output.info('Info message')
  #result
  =>[2018-09-09 15:41:34]INFO [] : "Info message"
```

Multiple outputs
```
  output = CustomLogging.logger(config:{output: 'BOTH', filename:'log/development', service_name: 'logging'})
  output.info('Info message')
  #result
  =>INFO  [2018-09-09 15:56:26][logging] : Info message
```

Hierarchical output
```
  output = CustomLogging.logger(config:{output: 'BOTH', filename:'log/development', service_name: 'logging'})
  child = CustomLogging.logger(config:{service_name: 'flash', has_parent: 'logging', filename: 'log/development'})
  output.info('Info message')
  #result
  =>INFO  [2018-09-09 15:56:26][logging] : Info message

  child.info('Info child message')
  =>INFO  logging::flash : Info child message
```

```
About config:
output: BOTH: STDOUT and File, nil: STDOUT
service_name: value from class that should be printed on log
has_parent: to hierarchical logs, inform the name from service that should be connected
filename: the name name from log be printed
```
