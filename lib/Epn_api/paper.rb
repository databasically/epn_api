module EpnApi
  class Paper
    
    attr_accessor :grade, :name, :annualqp, :recycledcontent, :trees, :water, :energy, :solid_waste, :greenhouse_gas
    
    def initialize(args)
      self.grade = args[:grade] or raise "Paper needs Grade"
      self.recycledcontent = args[:recycled_percent] or raise "Paper needs Recycled Percent"
      self.name = args[:name] || get_name( args[:grade] )
      self.annualqp= {"amount" => 10, "qpunits" => "tons"}   
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
    
  end
end
