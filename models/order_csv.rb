class OrderCSV
  attr_accessor :id, :coupom_id 
  def initialize(id, coupom_id)
    @id = id.to_i
    @coupom_id = coupom_id.to_i if coupom_id
  end
end
