require 'spec_helper'

describe "Api Transaction" do

  pending "should build the correct URI" do
  end
  
  pending "send the request" do
  end
  
  pending "should check for error codes" do
  end
  
  pending "should receive the response" do
  end
  
  pending "should check that the response is in the correct format" do
    response_xml = Factory.build(:response)
    response_xml.format_check?.should be_true
  end
  
  pending "should check that the response in not be in an incorrect format" do
    response_xml = "4"
    response_xml.format_check?.should be_false
  end
  

end