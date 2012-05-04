# -*- encoding: utf-8 -*-
require File.expand_path('../lib/hstore-attributes/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Christoph Sassenberg"]
  gem.email         = ["christoph.sassenberg@googlemail.com"]
  gem.description   = %q{ActiveRecord meta attributes that are mapped to a single (or multiple) hstore columns in postgres}
  gem.summary       = %q{ActiveRecord meta attributes that are mapped to a single (or multiple) hstore columns in postgres}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "hstore-attributes"
  gem.require_paths = ["lib"]
  gem.version       = HstoreAttributes::VERSION
end
