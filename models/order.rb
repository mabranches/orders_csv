INITIAL_PROGRESSIVE_PERCENTAGE = 0.1
ADITIONAL_PROGRESSIVE_PERCENTAGE = 0.05
MIN_LENGTH_DISCOUNT = 2
MAX_DISCOUNT=0.4

class Order
  attr_accessor :id, :products
  def initialize(id, products = nil)
    @id = id.to_i
    @total = 0.0
    @n_products = 0
  end

  def add_product(product)
    @n_products += 1
    @total += product.price
  end
  
  def final_value
    [@coupom_value||@total, progressive_value].min
  end
  
  def compute(coupom)
    @coupom_value ||= @total
    @coupom_value -= coupom_discount(coupom)
    coupom.mark_used
  end

  private

  def coupom_discount(coupom)
    coupom.type == Coupon::ABSOLUTE ? 
      coupom.value : @total * coupom.value/100.0
  end

  def progressive_value
    discount = 0
    if @n_products >= MIN_LENGTH_DISCOUNT
      discount = INITIAL_PROGRESSIVE_PERCENTAGE + (@n_products - MIN_LENGTH_DISCOUNT) * 
        ADITIONAL_PROGRESSIVE_PERCENTAGE
    end
    @total * (1.0 - [discount, MAX_DISCOUNT].min)
  end
  
end
