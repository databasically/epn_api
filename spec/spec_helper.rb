$:.unshift File.expand_path('..', __FILE__)
$:.unshift File.expand_path('../../lib', __FILE__)

require 'simplecov'
SimpleCov.start

require 'webmock/rspec'
require 'epn_api'
require 'rspec'