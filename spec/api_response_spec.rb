
describe "API Response" do
  
  it "should be in the correct format" do
    response_xml = Factory.build(:response)
    response_xml.format_check?.should be_true
  end
  
  it "should not be in an incorrect format" do
    response_xml = "4"
    response_xml.format_check?.should be_false
  end
  
  it "should parse response XML to ruby hash" do
    response_xml = Factory.build(:response)
    response_hash = response_xml.to_ruby
    response_hash.should be_valid
  end
  
end