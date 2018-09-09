
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "custom_logging/version"

Gem::Specification.new do |spec|
  spec.name          = "custom_logging"
  spec.version       = "0.0.3"
  spec.authors       = ["Ana Carolina Ferreira"]
  spec.email         = ["acosferreira@gmail.com"]
  spec.summary       = "Custom gem to manage log on projects"
  spec.description   = "Custom gem to manage log on projects"
  spec.license       = "MIT"
  spec.require_paths = ["lib"]
  spec.files       = ["lib/custom_logging.rb, 'lib/custom_logging/default_logger.rb', 'lib/custom_logging/default_formatter'"]
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "logging"
  spec.add_development_dependency 'timecop'
  spec.add_development_dependency 'byebug'
end
