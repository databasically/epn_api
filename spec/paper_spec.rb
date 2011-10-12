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
    paper.annualqp.should == {"amount" => 100, "qpunits" => "tons"}
    paper.recycledcontent.should == 30
  end
  
  it "should convert to XML doc" do
    # sample =
    # '<?xml version="1.0"?>
    # <papers client="1E1SLaUlfvOKO3q5MLC01x4Ap6M">
    #   <group id="0" name="default">
    #     <paper name="PaperApi">
    #       <grade>1</grade>
    #       <name>Uncoated Freesheet (e.g. copy paper)</name>
    #       <annualqp>100</annualqp>
    #       <qpunits value="tons" />
    #       <recycledcontent>30</recycledcontent>
    #     </paper>
    #   </group>
    # </papers>'
    
    f = File.open("sample.xml")
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