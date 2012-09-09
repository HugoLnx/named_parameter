# -*- encoding: utf-8 -*-
require File.expand_path('../lib/named_parameter/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Hugo Roque"]
  gem.email         = ["hugolnx@gmail.com"]
  gem.description   = %q{Allows named parameter in ruby}
  gem.summary       = %Q{named_parameter-#{NamedParameter::VERSION}}
  gem.homepage      = "http://github.com/hugolnx/named_parameter/"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "named_parameter"
  gem.require_paths = ["lib"]
  gem.version       = NamedParameter::VERSION
end
