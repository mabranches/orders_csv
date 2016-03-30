require 'spec_helper'

describe Order do
  before(:each) do
    @order = Order.new(1)   
    @coupon = Coupon.new(1, 25, Coupon::PERCENT, (Date.today + 100).strftime("%Y/%m/%d"), 1)
    
  end

  it "should use discount from coupon if it is better" do
     (1..3).each do |id|
        @order.add_product(Product.new(id,100))
     end
     @order.compute(@coupon)
     expect(@order.final_value).to eq(225)
  end 
  
  it "should use progressive discount if it is better" do
     (1..8).each do |id|
        @order.add_product(Product.new(id,100))
     end
     @order.compute(@coupon)
     expect(@order.final_value).to eq(480)
  end 
 
  it "should not be able to use the same product twice" do
    @order.add_product(Product.new(1,10))
    @order.add_product(Product.new(1,10))
     
    expect(@order.final_value).to eq(10)
  end
 
end
