module EpnApi
  module Api
    
    
    def uri_builder
      uri = "http://calculator.environmentalpaper.org/v0/xml"
      return URI.parse(uri)
    end
    
    def get_epn_response( request_doc )
      path = self.uri_builder
      Net::HTTP.get( path )
    end

    
    
  end
end