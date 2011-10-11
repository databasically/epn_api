# encoding: utf-8

Gem::Specification.new do |gem|
  gem.add_development_dependency 'rake', '~> 0.9'
  gem.add_development_dependency 'rdoc', '~> 3.8'
  gem.add_development_dependency 'rspec', '~> 2.6'
  gem.add_development_dependency 'webmock', '~> 1.7'
  gem.authors = ["Wes Garrison", "Chad Metcalf"]
  gem.description = %q{Ruby wrapper for the New Leaf Paper API}
  gem.name = 'nflapi'
  gem.require_paths = ['lib']
  gem.summary = gem.description
end
