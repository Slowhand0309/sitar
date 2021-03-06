# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sitar/version'

Gem::Specification.new do |spec|
  spec.name          = "sitar"
  spec.version       = Sitar::VERSION
  spec.authors       = ["Slowhand0309"]
  spec.email         = ["slowhand0309@gmail.com"]
  
  spec.required_ruby_version = ">= 2.0.0"

  spec.summary       = %q{Sitar is easy to use the fiddle}
  spec.description   = %q{You can used C method only to extend module with Sitar and load shared library.}
  spec.homepage      = "https://github.com/Slowhand0309/sitar"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "activesupport", "~> 4.0"

  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
