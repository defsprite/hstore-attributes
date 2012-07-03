# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.authors       = ["Christoph Sassenberg"]
  gem.email         = ["christoph.sassenberg@googlemail.com"]
  gem.description   = %q{ActiveRecord meta attributes that are mapped to a single (or multiple) hstore columns in postgres}
  gem.summary       = %q{ActiveRecord meta attributes that are mapped to a single (or multiple) hstore columns in postgres}
  gem.homepage      = "http://github.com/defsprite/hstore-attributes"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "hstore-attributes"
  gem.require_paths = ["lib"]
  gem.version       = "0.0.3"

  gem.add_dependency('pg')
  gem.add_dependency('activerecord', '>= 3.0')
  gem.add_dependency('activerecord-postgres-hstore')

end
