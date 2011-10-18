require 'spec_helper'

describe "Paper " do

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
    paper.annualqp.should == {"amount" => 10, "qpunits" => "tons"}
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
  
  it "should return false if the existing and new paper values are the same" do
    paper = EpnApi::Paper.new(:grade => 1, :recycled_percent => 30, :trees => 1, :water => 1, :energy => 1, :solid_waste => 1, :greenhouse_gas => 1) 
    existing_paper = paper.clone
    paper.compare(existing_paper).should be_false
  end
  
  it "should return the new values if the existing and new paper values are the same" do
    paper = EpnApi::Paper.new(:grade => 1, :recycled_percent => 30, :trees => 1, :water => 1, :energy => 1, :solid_waste => 1, :greenhouse_gas => 1) 
    existing_paper = EpnApi::Paper.new(:grade => 1, :recycled_percent => 30, :trees => 2, :water => 1, :energy => 1, :solid_waste => 1, :greenhouse_gas => 1) 
    paper.compare(existing_paper).should_not be_false
  end
  
end