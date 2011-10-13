module NlpApi
  class Paper
    include Api
    
    attr_accessor :grade, :name, :annualqp, :recycledcontent, :trees, :water, :energy, :solid_waste, :greenhouse_gas
    
    def initialize(paper_id, recycled_percent)
      self.grade = paper_id
      self.name = get_name( paper_id )
      self.annualqp= {"amount" => 10, "qpunits" => "tons"}
      self.recycledcontent = recycled_percent
    end
    
    def get_name(paper_id)
      paper_name_hash = self.initialize_paper_hash
      paper_name_hash[paper_id]
    end
    
    def initialize_paper_hash
      paper_name_hash = {
        1  =>  "Uncoated Freesheet (e.g. copy paper)"        ,
        2  =>  "Coated Freesheet (e.g. high-end catalog)"    ,
        3  =>  "Uncoated Groundwood (e.g. newsprint)"        ,
        4  =>  "Coated Groundwood (e.g. catalog, magazine)"  ,
        5  =>  "Supercalendered (e.g. newspaper inserts)"    ,
        6  =>  "Corrugated: Unbleached"                      ,
        7  =>  "Corrugated: Semi-bleached"                   ,
        8  =>  "Corrugated: Bleached"                        ,
        9  =>  "Paperboard: Solid Bleached Sulfate (SBS)"    ,
        10 =>  "Paperboard: Coated Unbleached Kraft (CUK)"   ,
        11 =>  "Paperboard: Uncoated Bleached Kraft"         ,
        12 =>  "Paperboard: Uncoated Unbleached Kraft"       ,
        13 =>  "Paperboard: Coated Recycled Board (CRB)"     ,
      }
    end
    
    def to_epn_xml
      builder = Nokogiri::XML::Builder.new do |xml|
        xml.papers('client' => "1E1SLaUlfvOKO3q5MLC01x4Ap6M") do
          xml.group('id' => '0', 'name' => "default") do
            xml.paper('name' => 'PaperApi') do
              xml.grade_ self.grade
              xml.name_ self.name
              xml.annualqp_ self.annualqp['amount']
              xml.qpunits('value' => "#{self.annualqp["qpunits"]}")
              xml.recycledcontent_ self.recycledcontent
            end
          end
        end
      end
      builder.to_xml
    end
    
    def from_epn_xml(return_doc)
      return_xml = Nokogiri::XML( return_doc)
      
    end
    
    def self.response(response_doc)
      self.response_to_hash(response_doc)

    end
    
    def self.response_to_hash(response_doc)
      response = Hash.new
      doc = Nokogiri::HTML(response_doc)
      doc.xpath('//paper/grade').each do |node|
        response["grade"] = node.text.strip
      end
      doc.xpath('//paper/name').each do |node|
        response["name"] = node.text.strip
      end
      doc.xpath('//paper/annualqp').each do |node|
        response["annualqp"] ||= {}
        response["annualqp"]["amount"] = node.text.strip
      end
      doc.xpath('//paper/qpunits').each do |node|
        response["annualqp"] ||= {}
        response["annualqp"]["qpunits"] = node.attributes['value'].value.strip
      end
      doc.xpath('//paper/recycledcontent').each do |node|
        response["recycledcontent"] = node.text.strip
      end
      doc.xpath('//eparam').each do |node|
        response["#{node.xpath('name').text.strip}"] ||= {}
        response["#{node.xpath('name').text.strip}"]['unit'] = node.xpath('unit').text.strip
        response["#{node.xpath('name').text.strip}"]['value'] = node.xpath('value').text.strip
      end
      response
    end
    
  end
end
