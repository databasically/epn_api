require 'spec_helper'

describe "Api Transaction" do

  it "should build the correct URI" do
    paper_doc = EpnApi::Paper.new(:grade => 5, :recycled_percent => 30 )
    api_doc = EpnApi::ApiDoc.new
    request_xml = api_doc.to_epn_xml( paper_doc )
    test_uri = "http://calculator.environmentalpaper.org/v0/xml"
    api_doc = EpnApi::ApiDoc.new
  
    api_doc.uri_builder(request_xml).should be_an_instance_of(URI::HTTP)
  end

  it "should send the request" do
    paper_doc = EpnApi::Paper.new(:grade => 5, :recycled_percent => 30 )
    api_doc = EpnApi::ApiDoc.new
    request_xml = api_doc.to_epn_xml( paper_doc )
    stub_request(:get, "#{api_doc.uri_builder(request_xml)}").to_return(:body => "Sent", :header => "200")
    
    response_doc = api_doc.get_epn_response( request_xml )
    (response_doc.body =~ /Sent/).should be_true

  end
  
  pending "should catch 200 status" do
    paper_doc = EpnApi::Paper.new(:grade => 5, :recycled_percent => 30 )
    api_doc = EpnApi::ApiDoc.new
    request_xml = api_doc.to_epn_xml( paper_doc )
    stub_request(:get, "#{api_doc.uri_builder(request_xml)}").to_return(:body => "Sent", :header => "200")
    
    response_doc = api_doc.get_epn_response( request_xml )
    (response_doc.inspect =~ /200/).should be_true
  end
  
  pending "should catch 400 status" do
    paper_doc = EpnApi::Paper.new(:grade => 5, :recycled_percent => 30 )
    api_doc = EpnApi::ApiDoc.new
    request_xml = api_doc.to_epn_xml( paper_doc )
    stub_request(:get, "#{api_doc.uri_builder(request_xml)}").to_return(:body => "Incorrect", :header => "400")
    
    response_doc = api_doc.get_epn_response( request_xml )
    (response_doc =~ /400/).should be_true
  end
  
  pending "should catch 500 status" do
    paper_doc = EpnApi::Paper.new(:grade => 5, :recycled_percent => 30 )
    api_doc = EpnApi::ApiDoc.new
    request_xml = api_doc.to_epn_xml( paper_doc )
    stub_request(:get, "#{api_doc.uri_builder(request_xml)}").to_return(:body => "Error", :header => "200")
    
    response_doc = api_doc.get_epn_response( request_xml )
    (response_doc =~ /500/).should be_true
  end
  
  
end