module EpnApi
  class ApiDoc
    include Api
    
    attr_accessor :grade, :name, :annualqp, :recycledcontent, 
                  :bod, :cod, :greenhouse_gas, :hap, :nox, :particulates,
                  :purchased_energy,:solid_waste, :so2, :net_energy, :trs,
                  :tss, :voc, :wastewater, :wood_use
    
    
    TREES_PER_TON_OF_WOOD_USE = 6.93
    
    def to_epn_xml( paper )
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.papers('client' => self.get_api_code) do
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
    
    def get_api_code
      api_code = ''
      File.open("./api_code", "r") { |f|
          api_code = f.read
      }
      return api_code
    end

    def from_epn_api(response_body)
      doc = Nokogiri::HTML(response_body)
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

        hash = {"unit" => node.xpath('unit').text.strip, "value" => node.xpath('value').text.strip}
        self.send("#{node_name}=", hash)
      end
      nil
    end
    
    def check_epn( request_xml )
      response = self.get_epn_response( request_xml )
      if response.inspect =~ /200/
        self.from_epn_api( response.body )
      end
    end
    
    def do_conversions!( paper )
      #these calculation only work if the unit is 100000 pounds
      unit = paper.unit_check
      
      paper.trees = ((self.wood_use["value"].to_f/unit) * TREES_PER_TON_OF_WOOD_USE)
      paper.water = (self.wastewater["value"].to_f/unit)
      paper.energy = (self.net_energy["value"].to_f/unit)
      paper.solid_waste = (self.solid_waste["value"].to_f/unit)
      paper.greenhouse_gas = (self.greenhouse_gas["value"].to_f/unit)
      return nil
    end
    
    def epn_response!( paper )
      request_xml = self.to_epn_xml( paper )
      self.check_epn( request_xml )
      self.do_conversions!( paper )
      return paper
    end


  end
end
