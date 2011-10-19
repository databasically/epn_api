require 'spec_helper'

describe "Paper" do

  it "should choose the correct paper name from the grade" do
    paper1 = EpnApi::Paper.new(:grade => 1, :recycled_percent => 30)
    (paper1.name =~ /Uncoated Freesheet/).should be_true

    paper2 = EpnApi::Paper.new(:grade => 5, :recycled_percent => 30)
    (paper2.name =~ /Supercalendered/).should be_true
    
    paper3 = EpnApi::Paper.new(:grade => 10, :recycled_percent => 30)
    (paper3.name =~ /CUK/).should be_true
  end
  
  it "should initialize when given a grade and recycled content" do
    paper = EpnApi::Paper.new(:grade => 1, :recycled_percent => 30)
    paper.grade.should == 1
    (paper.name =~ /Uncoated Freesheet/).should be_true
    paper.annualqp.should == {"amount" => 100000, "qpunits" => "pounds"}
    paper.recycledcontent.should == 30
  end
  
  it "should initialize when given a grade and recycled content and other fields" do
    paper = EpnApi::Paper.new(:grade => 1, :recycled_percent => 30, :trees => 1, :water => 1, :energy => 1, :solid_waste => 1, :greenhouse_gas => 1) 
    paper.energy.should == 1
    paper.greenhouse_gas == 1
  end
  
  it "should raise an exception if no arguement is provided" do
    lambda { EpnApi::Paper.new() }.should raise_error
  end
  
  it "should raise an exception if paper grade is not provided" do
    lambda { EpnApi::Paper.new(:recycled_percent => 30) }.should raise_error
  end
  
  it "should raise an exception if recycled percent is not provided" do
    lambda { EpnApi::Paper.new(:grade => 1) }.should raise_error
  end
  
  it "should not raise an exception if grade and recycled percent are provided" do
    lambda { EpnApi::Paper.new(:grade => 1, :recycled_percent => 30) }.should_not raise_error
  end
  
  it "should return the new values" do
    paper = EpnApi::Paper.new(:grade => 1, :recycled_percent => 30, :trees => 1, :water => 1, :energy => 1, :solid_waste => 1, :greenhouse_gas => 1) 
    existing_paper = EpnApi::Paper.new(:grade => 1, :recycled_percent => 30, :trees => 1, :water => 1, :energy => 1, :solid_waste => 1, :greenhouse_gas => 1) 
    response_xml = File.open("./spec/samples/response.xml")
    
    path = "http://calculator.environmentalpaper.org/v0/xml?papers=%3C?xml%20version=%221.0%22?%3E%0A%3Cpapers%20client=%221E1SLaUlfvOKO3q5MLC01x4Ap6M%22%3E%0A%20%20%3Cgroup%20id=%220%22%20name=%22default%22%3E%0A%20%20%20%20%3Cpaper%20name=%22PaperApi%22%3E%0A%20%20%20%20%20%20%3Cgrade%3E1%3C/grade%3E%0A%20%20%20%20%20%20%3Cname%3EUncoated%20Freesheet%20(e.g.%20copy%20paper)%3C/name%3E%0A%20%20%20%20%20%20%3Cannualqp%3E100000%3C/annualqp%3E%0A%20%20%20%20%20%20%3Cqpunits%20value=%22pounds%22/%3E%0A%20%20%20%20%20%20%3Crecycledcontent%3E30%3C/recycledcontent%3E%0A%20%20%20%20%3C/paper%3E%0A%20%20%3C/group%3E%0A%3C/papers%3E%0A"
    stub_request(:get, path).to_return(:status => 200, :body => response_xml, :headers => {})
    
    paper = paper.update_via_epn
    paper.should be_an_instance_of(EpnApi::Paper)
    existing_paper.energy.should_not == paper.energy
  end
  
  it "should raise an exception if the unit is unacceptable" do
    paper = EpnApi::Paper.new(:grade => 1, :recycled_percent => 30)
    paper.annualqp["qpunits"] = 'tons'
    lambda { paper.unit_check }.should raise_error
  end
  
  it "should return the conversion value if the unit is acceptable" do
    paper = EpnApi::Paper.new(:grade => 1, :recycled_percent => 30)
    paper.unit_check.should == 100000
  end
  

  # REMOVED THIS FEATURE, LET RAILS HANDLE THE COMPARING OF THE OBJECTS
  # it "should return false if the existing and new paper values are the same using compare method" do
  #   paper = EpnApi::Paper.new(:grade => 1, :recycled_percent => 30, :trees => 1, :water => 1, :energy => 1, :solid_waste => 1, :greenhouse_gas => 1) 
  #   existing_paper = paper.clone
  #   paper.compare(existing_paper).should be_false
  # end

  # it "should return the new values if the existing and new paper values are the same using compare method" do
  #   paper = EpnApi::Paper.new(:grade => 1, :recycled_percent => 30, :trees => 1, :water => 1, :energy => 1, :solid_waste => 1, :greenhouse_gas => 1) 
  #   existing_paper = EpnApi::Paper.new(:grade => 1, :recycled_percent => 30, :trees => 2, :water => 1, :energy => 1, :solid_waste => 1, :greenhouse_gas => 1) 
  #   paper.compare(existing_paper).should_not be_false
  # end
  
  # it "should return a string without the object info" do
  #   paper = EpnApi::Paper.new(:grade => 1, :recycled_percent => 30, :trees => 1, :water => 1, :energy => 1, :solid_waste => 1, :greenhouse_gas => 1)
  #   paper.object_id_strip_from_string.gsub!(paper.extract_id, '').nil?.should be_true
  # end
  
  # it "should return false if the existing and new paper values are the same using update_paper method" do
  #   paper = EpnApi::Paper.new(:grade => 5, :recycled_percent => 30, :trees => 1, :water => 1, :energy => 1, :solid_waste => 1, :greenhouse_gas => 1) 
  #   existing_paper = paper.clone
  #   api_doc = EpnApi::ApiDoc.new
  #   request_xml = api_doc.to_epn_xml( paper )
  #   response_xml = File.open("./spec/samples/response.xml")
  #   stub_request(:get, "#{api_doc.uri_builder(request_xml)}").to_return(:body => response_xml, :header => "200")
  #   
  #   p paper
  #   p existing_paper
  #   
  #   p paper.update_paper
  #   
  # end
  
  

  
end