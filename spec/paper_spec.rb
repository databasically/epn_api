require 'spec_helper'

describe "Paper " do

  it "should choose the correct paper name from the grade" do
    paper1 = NlpApi::Paper.new(1,30)
    (!(paper1.name =~ /Uncoated Freesheet/).nil?).should be_true
    
    paper2 = NlpApi::Paper.new(5,30)
    (!(paper2.name =~ /Supercalendered/).nil?).should be_true
    
    paper3 = NlpApi::Paper.new(10,30)
    (!(paper3.name =~ /CUK/).nil?).should be_true
  end
  
  it "should initialize fully when given a grade and recycled content" do
    paper = NlpApi::Paper.new(1,30)
    paper.grade.should == 1
    (!(paper.name =~ /Uncoated Freesheet/).nil?).should be_true
    paper.annualqp.should == {"amount" => 10, "qpunits" => "tons"}
    paper.recycledcontent.should == 30
  end
  
  it "should convert to XML doc" do
    f = File.open("./spec/samples/request.xml")
    sample_doc = Nokogiri::XML(f)
    f.close
    
    paper_doc = NlpApi::Paper.new(5,30).to_epn_xml
    paper_doc.should == "#{sample_doc}"
  end
  
  pending "should parse response XML to paper object" do
    response_xml = Factory.build(:response)
    response = response_xml.to_paper_type
    response.should be_valid
  end
  
end