class Product
  attr_accessor :id, :price
  def initialize(id, price)
    @id = id
    @price = price.to_f
  end
end
