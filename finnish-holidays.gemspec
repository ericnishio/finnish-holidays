# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'finnish-holidays/version'

Gem::Specification.new do |spec|
  spec.name          = "finnish-holidays"
  spec.version       = FinnishHolidays::VERSION
  spec.authors       = ["Eric Nishio"]
  spec.email         = ["eric@self-learner.com"]

  spec.summary       = %q{A CLI and utility library for listing Finnish national holidays.}
  spec.description   = %q{Lists Finnish national holidays.}
  spec.homepage      = "https://github.com/ericnishio/finnish-holidays"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = "finnish-holidays"
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
end
