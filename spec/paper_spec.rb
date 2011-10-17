require 'spec_helper'

describe "Paper " do

  it "should choose the correct paper name from the grade" do
    paper_grade = 1
    recycled_content = 30
    paper1 = EpnApi::Paper.new(paper_grade,recycled_content)
    (paper1.name =~ /Uncoated Freesheet/).should be_true
    
    paper_grade = 5
    paper2 = EpnApi::Paper.new(paper_grade,recycled_content)
    (paper2.name =~ /Supercalendered/).should be_true
    
    paper_grade = 10
    paper3 = EpnApi::Paper.new(paper_grade,recycled_content)
    (paper3.name =~ /CUK/).should be_true
  end
  
  it "should initialize fully when given a grade and recycled content" do
    paper_grade = 1
    recycled_content = 30
    paper = EpnApi::Paper.new(paper_grade,recycled_content)
    paper.grade.should == 1
    (paper.name =~ /Uncoated Freesheet/).should be_true
    paper.annualqp.should == {"amount" => 10, "qpunits" => "tons"}
    paper.recycledcontent.should == 30
  end
  
end