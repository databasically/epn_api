describe "Api Request" do

  it "should build the request document" do
    fact_request = Factory.build(:request)
    built_request = request.build(1, 20)
    built_request.should == fact_request
  end
  
  it "should convert to XML" do
    request = Factory.build(:request)
    request_doc = request.to_epn_xml
    request_doc.should be_valid
  end
  
end

