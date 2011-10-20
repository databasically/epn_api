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
    
    response_doc = @api_doc.get_epn_response_doc( @request_xml )
  end
  
  it "should return a response" do
    response_xml = File.open("./spec/samples/response.xml")
    stub_request(:get, "#{@api_doc.uri_builder(@request_xml)}").to_return(:body => response_xml, :header => "200")
    
    response_doc = @api_doc.get_epn_response_doc( @request_xml )
    response_doc.should be_an_instance_of(Net::HTTPOK)
  end
  
  it "should allow a 200 status to pass" do
    stub_request(:get, "#{@api_doc.uri_builder(@request_xml)}").to_return(:body => "Sent", :status => 200)
  
    response_doc = @api_doc.get_epn_response_doc( @request_xml )
    @api_doc.accept_status( response_doc ).should be_true
  end
  
  it "should block anything else" do
    stub_request(:get, "#{@api_doc.uri_builder(@request_xml)}").to_return(:body => "Sent", :status => 300)
  
    response_doc = @api_doc.get_epn_response_doc( @request_xml )
    lambda { @api_doc.accept_status( response_doc ) }.should raise_error
  end
  
  it "should catch 400 status" do
    stub_request(:get, "#{@api_doc.uri_builder(@request_xml)}").to_return(:body => "Incorrect", :status => 400)
    
    response_doc = @api_doc.get_epn_response_doc( @request_xml )
    lambda { @api_doc.accept_status( response_doc ) }.should raise_error
  end
  
  it "should catch 500 status" do
    stub_request(:get, "#{@api_doc.uri_builder(@request_xml)}").to_return(:body => "Error", :status => 500)
    
    response_doc = @api_doc.get_epn_response_doc( @request_xml )
    lambda { @api_doc.accept_status( response_doc ) }.should raise_error
  end
  
end