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
    request_doc = Nokogiri::XML(f)
    f.close
    
    paper_doc = NlpApi::Paper.new(5,30).to_epn_xml
    paper_doc.should == "#{request_doc}"
  end
  
  it "should parse response XML to a hash" do
    sample = {"grade"=>"5", "name"=>"Supercalendered", "annualqp"=>{"amount"=>"10", "qpunits"=>"tons"}, "recycledcontent"=>"30", "bod"=>{"unit"=>"pounds", "value"=>"65"}, "cod"=>{"unit"=>"pounds", "value"=>"139"}, "greenhouse_gas"=>{"unit"=>"pounds CO2 equiv.", "value"=>"59227"}, "hap"=>{"unit"=>"pounds", "value"=>"20"}, "nox"=>{"unit"=>"pounds", "value"=>"104"}, "particulates"=>{"unit"=>"pounds", "value"=>"48"}, "purchased_energy"=>{"unit"=>"million BTU's", "value"=>"256"}, "solid_waste"=>{"unit"=>"pounds", "value"=>"18604"}, "so2"=>{"unit"=>"pounds", "value"=>"293"}, "net_energy"=>{"unit"=>"million BTU's", "value"=>"299"}, "trs"=>{"unit"=>"pounds", "value"=>"3"}, "tss"=>{"unit"=>"pounds", "value"=>"103"}, "voc"=>{"unit"=>"pounds", "value"=>"20"}, "wastewater"=>{"unit"=>"gallons", "value"=>"126569"}, "wood_use"=>{"unit"=>"tons", "value"=>"19"}}
    
    f = File.open("./spec/samples/response.xml")
    response_hash = NlpApi::Paper.response(f)
    
    response_hash.should == sample
  end
  
  pending "should update the paper object" do
    
  end
  
end