
require "./lib/nlp_api.rb"


paper1 = NlpApi::Paper.new(2,30)

paper2 = NlpApi::Paper.new(5,100)

paper3 = NlpApi::Paper.new(10,30)

paper4 = NlpApi::Paper.new(13,30)


@paper= [paper1, paper2, paper3, paper4]

@paper.each do |p|
  p.to_epn_xml
end

# builder = Nokogiri::XML::Builder.new do |xml|
#   xml.papers('client' => "1E1SLaUlfvOKO3q5MLC01x4Ap6M") do
#     xml.group('id' => '0', 'name' => "default") do
#       xml.paper('name' => 'PaperApi') do
#         xml.grade_ @paper.grade
#         xml.name_ @paper.name
#         xml.annualqp_ @paper.annualqp['amount']
#         xml.qpunits('value' => "#{@paper.annualqp["qpunits"]}")
#         xml.recycledcontent_ @paper.recycledcontent
#       end
#     end
#   end
# end
# puts builder.to_xml
