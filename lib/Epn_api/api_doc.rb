module EpnApi
  class ApiDoc
    
    attr_accessor :grade, :name, :annualqp, :recycledcontent, 
                  :bod, :cod, :greenhouse_gas, :hap, :nox, :particulates,
                  :purchased_energy,:solid_waste, :so2, :net_energy, :trs,
                  :tss, :voc, :wastewater, :wood_use
    
    
    def to_epn_xml( paper )
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.papers('client' => "1E1SLaUlfvOKO3q5MLC01x4Ap6M") do
          xml.group('id' => '0', 'name' => "default") do
            xml.paper('name' => 'PaperApi') do
              xml.grade_ paper.grade
              xml.name_ paper.name
              xml.annualqp_ paper.annualqp['amount']
              xml.qpunits('value' => "#{paper.annualqp["qpunits"]}")
              xml.recycledcontent_ paper.recycledcontent
            end
          end
        end
      end
      builder.to_xml
    end

    def from_epn_api(response_doc)
      doc = Nokogiri::HTML(response_doc)
      doc.xpath('//paper/grade').each do |node|
        self.grade= node.text.strip
      end
      doc.xpath('//paper/name').each do |node|
        self.name = node.text.strip
      end
      doc.xpath('//paper/annualqp').each do |node|
        self.annualqp ||= {}
        self.annualqp["amount"] = node.text.strip
      end
      doc.xpath('//paper/qpunits').each do |node|
        self.annualqp ||= {}
        self.annualqp["qpunits"] = node.attributes['value'].value.strip
      end
      doc.xpath('//paper/recycledcontent').each do |node|
        self.recycledcontent = node.text.strip
      end
      doc.xpath('//eparam').each do |node|
        node_name = node.xpath('name').text.strip
        self.send(node_name + '=', node_name)        
        # self.send(node_name + '=', "||=", "{}")
        # self.send(node_name)['unit'] = node.xpath('unit').text.strip
        # self.send(node_name)['value'] = node.xpath('value').text.strip
        p self.node_name
      end
      nil
    end
  end
end
