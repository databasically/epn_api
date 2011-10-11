require 'spec_helper'

describe "Api Request" do

  pending "should build the request document" do
    fact_request = Factory.build(:request)
    built_request = NlpApi::Request.new(1, 20)
    built_request.should == fact_request
  end
  
  pending "should convert to XML" do
    request = Factory.build(:request)
    request_doc = request.to_epn_xml
    request_doc.should be_valid
  end
  
end

