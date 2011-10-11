
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
    response = response_xml.to_ruby
    response.should be_valid
  end
  
  
  it "should check for data change against database" do
    existing_data = Factory.build(:paper_info)
    response_xml = Factory.build(:response)
    response = response_xml.to_ruby
    response.changed?.should be false
  end

  it "should check for data change against database" do
    existing_data = Factory.build(:paper_info)
    response_xml = Factory.build(:response, :wood_use.value => 18 )
    response = response_xml.to_ruby
    response.changed?.should be true
  end
end