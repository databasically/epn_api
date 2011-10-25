require 'nokogiri'
require 'net/http'
require 'yaml'

module EpnApi
  
  autoload :Paper,  "epn_api/paper"
  autoload :Api,    "epn_api/api"
  autoload :ApiDoc, "epn_api/api_doc"
  
  
  
end