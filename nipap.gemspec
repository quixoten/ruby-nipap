# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nipap/version'

Gem::Specification.new do |spec|
  spec.name          = "nipap"
  spec.version       = NIPAP::VERSION
  spec.authors       = ["Devin Christensen"]
  spec.email         = ["quixoten@gmail.com"]

  spec.summary       = %q{Ruby client for NIPAP (Neat IP Address Planner)}
  spec.homepage      = "https://github.com/quixoten/ruby-nipap"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "minitest", "~> 5.0"
end
