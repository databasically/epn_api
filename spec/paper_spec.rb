require 'spec_helper'

describe "Paper class" do
  it "chooses the correct paper name from the grade" do
    paper1 = NlpApi::Paper.new(1,30)
    (!(paper1.name =~ /Uncoated Freesheet/).nil?).should be_true
    
    paper2 = NlpApi::Paper.new(5,30)
    (!(paper2.name =~ /Supercalendered/).nil?).should be_true
    
    paper3 = NlpApi::Paper.new(10,30)
    (!(paper3.name =~ /CUK/).nil?).should be_true
  end
  
  it "initializes fully when given a grade and recycled content" do
    paper = NlpApi::Paper.new(1,30)
    paper.grade.should == 1
    (!(paper.name =~ /Uncoated Freesheet/).nil?).should be_true
    paper.annualqp.should == {"amount" => 100, "qpunits" => "tons"}
    paper.recycledcontent.should == 30
  end
  
end