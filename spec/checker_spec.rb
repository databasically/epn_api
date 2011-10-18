require 'spec_helper'

describe "Paper Notifier" do
  
  # not sure how to test this
  pending "should send notification if changed" do
    existing_paper_type = Factory.build(:paper_type)
    response_xml = Factory.build(:response)
    response = response_xml.to_paper_type
    response.send.should be_sent
  end
   
end