require 'spec_helper'

describe "Api Transaction" do

  it "should build the correct URI" do
    test_uri = "http://calculator.environmentalpaper.org/v0/xml"
    api_doc = EpnApi::ApiDoc.new
    api_doc.uri_builder.should be_an_instance_of(URI::HTTP)
  end

  it "send & recieve the request" do
    paper_doc = EpnApi::Paper.new(:grade => 5, :recycled_percent => 30 )
    api_doc = EpnApi::ApiDoc.new
    request_xml = api_doc.to_epn_xml( paper_doc )
    
    stub_request(:get, "http://calculator.environmentalpaper.org/v0/xml").to_return(:body => request_xml)
    
    return_doc = api_doc.get_epn_response    
  end
end