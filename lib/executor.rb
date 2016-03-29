Dir["./lib/csv*"].each {|file| require file }
Dir["./models/*"].each {|file| require file }
require 'byebug'

  FILES = [
     {var: :coupons, location:'spec/csvs/coupons.csv',method: :populate_hash, klass: Coupon},
     {var: :products, location:'spec/csvs/products.csv',method: :populate_hash, klass: Product},
     {var: :orders_csv, location:'spec/csvs/orders.csv',method: :populate_array, klass: OrderCSV},
     {var: :order_items, location:'spec/csvs/order_items.csv',method: :populate_array, klass: OrderItem},
  ]

class Executor 
  def initialize(source, target)
    @source = source
    @target = target
    @orders_hash = {}
  end

  def run
    read_data
    build_orders_hash
    add_order_items
    process_coupom
    output = comput_final_value
    @target.write(output) 
  end

  def comput_final_value
    @orders_hash.values.collect do |order|
      [order.id, order.final_value]
    end
  end

  #process coupons in the sequence found in source 
  def process_coupom
    @orders_csv.each do |oc|
      coupom = @coupons[oc.coupom_id]
      @orders_hash[oc.id].compute(coupom) if coupom && coupom.valid?
    end
  end

  #example of generated code  
  #source.location = 'csvs/cupons'
  #@products = source.populate_hash(Product)
  def read_data
    FILES.each do |file|
      @source.location = file[:location]
      instance_variable_set('@' + file[:var].to_s,
        @source.send(file[:method], file[:klass]))
    end
  end

  def build_orders_hash
    order_ids = @order_items.collect(&:order_id).sort.uniq
    order_ids.each{|o_id| @orders_hash[o_id] = Order.new(o_id)}
  end

  def add_order_items
     @order_items.each do |oi|
       @orders_hash[oi.order_id].add_product(@products[oi.product_id])
     end 
  end

end

exec = Executor.new(Source::CSVSource.new, Target::CSVTarget.new('./result.csv'))

exec.run
