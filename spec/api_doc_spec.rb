require 'spec_helper'

describe "Api_Doc" do
  
  it "should convert to XML doc" do
    f = File.open("./spec/samples/request.xml")
    sample_request_doc = Nokogiri::XML(f)
    f.close
    
    paper_doc = EpnApi::Paper.new(:grade => 5, :recycled_percent => 30 )
    
    api_doc = EpnApi::ApiDoc.new
    request_doc = api_doc.to_epn_xml( paper_doc )
    request_doc.should == "#{sample_request_doc}"
  end
  
  it "should parse response XML to an Api_Doc" do
    sample = {"grade"=>"5", "name"=>"Supercalendered", "annualqp"=>{"amount"=>"10", "qpunits"=>"tons"}, "recycledcontent"=>"30", "bod"=>{"unit"=>"pounds", "value"=>"65"}, "cod"=>{"unit"=>"pounds", "value"=>"139"}, "greenhouse_gas"=>{"unit"=>"pounds CO2 equiv.", "value"=>"59227"}, "hap"=>{"unit"=>"pounds", "value"=>"20"}, "nox"=>{"unit"=>"pounds", "value"=>"104"}, "particulates"=>{"unit"=>"pounds", "value"=>"48"}, "purchased_energy"=>{"unit"=>"million BTU's", "value"=>"256"}, "solid_waste"=>{"unit"=>"pounds", "value"=>"18604"}, "so2"=>{"unit"=>"pounds", "value"=>"293"}, "net_energy"=>{"unit"=>"million BTU's", "value"=>"299"}, "trs"=>{"unit"=>"pounds", "value"=>"3"}, "tss"=>{"unit"=>"pounds", "value"=>"103"}, "voc"=>{"unit"=>"pounds", "value"=>"20"}, "wastewater"=>{"unit"=>"gallons", "value"=>"126569"}, "wood_use"=>{"unit"=>"tons", "value"=>"19"}}
    
    response_doc = File.open("./spec/samples/response.xml")
    api_doc = EpnApi::ApiDoc.new
    api_doc.from_epn_api( response_doc )
    
    api_doc.grade.should == sample["grade"]
    api_doc.greenhouse_gas.should == sample["greenhouse_gas"]
    
  end
  
end