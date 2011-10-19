require 'spec_helper'

describe "Api Transaction" do
  
  before(:each) do
    @paper_doc = EpnApi::Paper.new(:grade => 5, :recycled_percent => 30 )
    @api_doc = EpnApi::ApiDoc.new
    @request_xml = @api_doc.to_epn_xml( @paper_doc )
  end

  it "should build the correct URI" do
    test_uri = "http://calculator.environmentalpaper.org/v0/xml"
    @api_doc.uri_builder(@request_xml).should be_an_instance_of(URI::HTTP)
  end

  it "should send the request" do
    stub_request(:get, "#{@api_doc.uri_builder(@request_xml)}").to_return(:body => "Sent", :header => "200")
    
    response_doc = @api_doc.get_epn_response( @request_xml )
  end
  
  it "should return a response" do
    response_xml = File.open("./spec/samples/response.xml")
    stub_request(:get, "#{@api_doc.uri_builder(@request_xml)}").to_return(:body => response_xml, :header => "200")
    
    response_doc = @api_doc.get_epn_response( @request_xml )
    response_doc.should be_an_instance_of(Net::HTTPOK)
  end
  
  # Checking the Object, not the return status
  # it "should catch 200 status" do
  #   stub_request(:get, "#{@api_doc.uri_builder(@request_xml)}").to_return(:body => "Sent", :header => "200")
  # 
  #   response_doc = @api_doc.get_epn_response( @request_xml )
  #   (response_doc.inspect =~ /200/).should be_true
  # end
  # 
  # it "should catch 400 status" do
  #   stub_request(:get, "#{@api_doc.uri_builder(@request_xml)}").to_return(:body => "Incorrect", :header => "400")
  #   
  #   response_doc = @api_doc.get_epn_response( @request_xml )
  #   (response_doc =~ /400/).should be_true
  # end
  # 
  # it "should catch 500 status" do
  #   stub_request(:get, "#{@api_doc.uri_builder(@request_xml)}").to_return(:body => "Error", :header => "200")
  #   
  #   response_doc = api_doc.get_epn_response( @request_xml )
  #   (response_doc =~ /500/).should be_true
  # end
  
end