class OrderItem
  attr_accessor :order_id, :product_id
  def initialize(order_id, product_id)
    @order_id = order_id.to_i
    @product_id = product_id.to_i
  end
end
