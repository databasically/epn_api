module EpnApi
  module Api
    
    
    def uri_builder
      return URI.parse("http://calculator.environmentalpaper.org/v0/xml")
    end
    
    def get_epn_response( request_doc )
      path = self.uri_builder
      Net::HTTP.get( path )
    end

    
    
  end
end