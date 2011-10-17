# encoding: utf-8

Gem::Specification.new do |gem|
  gem.add_development_dependency 'rake', '~> 0.9'
  gem.add_development_dependency 'rspec', '~> 2.6'
  gem.add_development_dependency 'webmock'
  gem.add_development_dependency 'simplecov'
  gem.authors = ["Wes Garrison", "Chad Metcalf"]
  gem.description = %q{Ruby wrapper for the Environmental Paper Netwrok API}
  gem.name = 'EpnApi'
  gem.require_paths = ['lib']
  gem.summary = gem.description
end
