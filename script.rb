require './lib/CSVParser.rb'

  def array_to_hash(array)
    temp = {}
    array.each{|a| temp[a[0]] = a }
    temp
  end
  files = {
    coupons: {location:'csvs/coupons.csv',method: :populate_hash, klass: Coupon},
    products: {location:'csvs/products.csv',method: :populate_hash, klass: Product},
    orders: {location:'csvs/orders.csv',method: :populate_array, klass: Order},
    order_items: {location:'csvs/order_items.csv',method: :populate_array, klass: OrderItem},
  }

  source = Source::CSVParser.new
  
  #example of generated code  
  #source.location = 'csvs/cupons'
  #@products = source.populate_hash(Product)

  files.each_pair do |var, attrs|
    source.location = attrs[:location]
    instance_variable_set('@' + var.to_s, source.send(attrs[:method], attrs[:klass]))
  end
 
  #calcular total do pedido percorrendo order_items e guardar em  hash com pedido(id key) valor inicial e valor por cupom
  #percorer cupons e 

   
