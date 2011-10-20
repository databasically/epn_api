module EpnApi
  module Api
    
    
    def uri_builder( request_xml )
      uri = URI.parse("http://calculator.environmentalpaper.org/v0/xml")
      
      url_value = URI.escape( request_xml )
      url_query = "papers=#{url_value}"
      
      encoded_url = URI::HTTP.build({:host => "calculator.environmentalpaper.org", :path => "/v0/xml", :query => url_query})
      return encoded_url
    end
    
    def get_epn_response_doc( request_xml )
      encoded_url = self.uri_builder( request_xml )
      Net::HTTP.get_response( encoded_url )
    end
    
    def accept_status( response_doc )
      if    (response_doc.inspect =~ /400/) then raise "HTTP Code 400 | Bad Request | The request cannot be fulfilled due to bad syntax."
      elsif (response_doc.inspect =~ /500/) then raise "HTTP Code 500 | Internal Server Error"
      elsif (response_doc.inspect =~ /200/) then return true
      else                                       raise "Unknown HTTP Code Error"
      end
    end
      
  end
end

# output URL
# "http://calculator.environmentalpaper.org/v0/xml?papers=%3C?xml%20version=%221.0%22?%3E%0A%3Cpapers%20client=%221E1SLaUlfvOKO3q5MLC01x4Ap6M%22%3E%0A%20%20%3Cgroup%20id=%220%22%20name=%22default%22%3E%0A%20%20%20%20%3Cpaper%20name=%22PaperApi%22%3E%0A%20%20%20%20%20%20%3Cgrade%3E5%3C/grade%3E%0A%20%20%20%20%20%20%3Cname%3ESupercalendered%20%28e.g.%20newspaper%20inserts%29%3C/name%3E%0A%20%20%20%20%20%20%3Cannualqp%3E10%3C/annualqp%3E%0A%20%20%20%20%20%20%3Cqpunits%20value=%22tons%22/%3E%0A%20%20%20%20%20%20%3Crecycledcontent%3E30%3C/recycledcontent%3E%0A%20%20%20%20%3C/paper%3E%0A%20%20%3C/group%3E%0A%3C/papers%3E%0A"
