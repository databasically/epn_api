

describe "Api" do
  it "should build the request document" do
    request_hash = Factory.build(:request)
    request_hash.should be_valid
  end
  
  it "should convert to XML" do
    request_hash = Factory.build(:request)
    request_doc = request_hash.to_xml
    request_doc.should be_valid
  end
  
  it "should parse response XML to ruby hash" do
    response_xml = Factory.build(:response)
    response_hash = response_xml.to_ruby
    response_hash.should be_valid
  end
end