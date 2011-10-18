module EpnApi
  class Paper
    
    attr_accessor :grade, :name, :annualqp, :recycledcontent, :trees, :water, :energy, :solid_waste, :greenhouse_gas
    
    def initialize(args)
      self.grade = args[:grade] or raise "Paper needs Grade"
      self.recycledcontent = args[:recycled_percent] or raise "Paper needs Recycled Percent"
      self.name = args[:name] || get_name( args[:grade] )
      self.annualqp= {"amount" => 10, "qpunits" => "tons"}   
    end
    
    def get_name(grade)
      paper_name_hash = self.initialize_paper_hash
      paper_name_hash[grade]
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
    
    def update_database
      #api_doc = EpnApi::ApiDoc.new
      #return_doc = api_doc( self ).check_epn_site
      #do some calculations to covert the api_doc to paper_doc numbers
      #return the paper_doc in hash form
      
    end
    
    def check_for_update
      api_doc = EpnApi::ApiDoc.new
      # if api_doc.to_epn_xml( paper ) == api_doc.response_calculations( paper )
      #   #update paper object or return false
      # end
    
    end
    
  end
end
