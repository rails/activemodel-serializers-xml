# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_model/serializers/version'

Gem::Specification.new do |spec|
  spec.name          = "activemodel-serializers-xml"
  spec.version       = ActiveModel::Serializers::VERSION
  spec.authors       = ["Zachary Scott"]
  spec.email         = ["e@zzak.io"]

  spec.summary       = "XML serialization for your Active Model objects and Active Record models - extracted from Rails"
  spec.homepage      = "http://github.com/rails/activemodel-serializers-xml"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.require_paths = ["lib"]
  spec.add_dependency "activesupport", "> 5.x"
  spec.add_dependency "activemodel", "> 5.x"
  spec.add_dependency "activerecord", "> 5.x"
  spec.add_dependency "builder", "~> 3.1"

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "sqlite3"
end
