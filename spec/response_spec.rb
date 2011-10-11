require 'spec_helper'

describe "Api Response" do
  
  pending "should be in the correct format" do
    response_xml = Factory.build(:response)
    response_xml.format_check?.should be_true
  end
  
  pending "should not be in an incorrect format" do
    response_xml = "4"
    response_xml.format_check?.should be_false
  end
  
  pending "should parse response XML to paper object" do
    response_xml = Factory.build(:response)
    response = response_xml.to_paper_type
    response.should be_valid
  end
  
  
  pending "should check for same data against database" do
    existing_paper_type = Factory.build(:paper_type)
    response_xml = Factory.build(:response)
    response = response_xml.to_paper_type
    response.changed?.should be_false
  end

  pending "should check for changed data against database" do
    existing_paper_type = Factory.build(:paper_type)
    response_xml = Factory.build(:response, :trees.value = 18 )
    response = response_xml.to_paper_type
    response.changed?.should be_true
  end
  
  pending "should update the database" do
    existing_paper_type = Factory.build(:paper_type)
    existing_paper_type.trees.value.should != 18
    response_xml = Factory.build(:response, :trees.value = 18 )
    response = response_xml.to_paper_type
    response.update_data
    existing_paper_type.trees.value.should == 18
  end
  
  # not sure how to test this
  pending "should send notification if changed" do
     existing_paper_type = Factory.build(:paper_type)
     response_xml = Factory.build(:response)
     response = response_xml.to_paper_type
     response.send.should be_sent
   end
   
end