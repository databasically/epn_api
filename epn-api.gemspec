# encoding: utf-8

require File.expand_path('../lib/epn_api/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency 'nokogiri', '1.3.3'
  gem.add_dependency 'multi_json', '~> 1.0.3'
  gem.add_development_dependency 'rake', '~> 0.9'
  gem.add_development_dependency 'rdoc', '~> 3.8'
  gem.add_development_dependency 'rspec', '~> 2.6'
  gem.add_development_dependency 'simplecov', '~> 0.5'
  gem.add_development_dependency 'webmock', '~> 1.7'
  gem.author = 'Chad Metcalf'
  gem.description = %q{Ruby wrapper for the Environmental Paper Network API}
  gem.email = 'chad@databasically.com'
  gem.files = `git ls-files`.split("\n")
  gem.homepage = 'http://github.com/databasically/epn_api'
  gem.name = 'epn-api'
  gem.require_paths = ['lib']
  gem.summary = %q{Ruby wrapper for the Environmental Paper Network Eco Calculator API}
  gem.test_files = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.version = EpnApi::VERSION::STRING
end