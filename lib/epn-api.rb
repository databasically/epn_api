require 'nokogiri'
require 'net/http'
require 'yaml'

require File.expand_path("epn_api/paper.rb",File.dirname(__FILE__))
require File.expand_path("epn_api/api.rb",File.dirname(__FILE__))
require File.expand_path("epn_api/api_doc.rb",File.dirname(__FILE__))

module EpnApi
  
  autoload :Paper,  "epn_api/paper"
  autoload :Api,    "epn_api/api"
  autoload :ApiDoc, "epn_api/api_doc"
  
  
  
end