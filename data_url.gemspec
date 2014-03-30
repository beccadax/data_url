# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'data_url/version'

Gem::Specification.new do |spec|
  spec.name          = "data_url"
  spec.version       = DataURL::VERSION
  spec.authors       = ["Brent Royal-Gordon"]
  spec.email         = ["brent@groundbreakingsoftware.com"]
  spec.summary       = %q{Data URL support}
  spec.description   = %q{Parse and create data: URLs}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.4"
  spec.add_development_dependency "rake"
end
