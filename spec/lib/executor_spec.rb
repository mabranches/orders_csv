require 'spec_helper'

describe Executor do
  it 'should create a csv with correct output' do
    argv = %w(spec/csvs/coupons.csv spec/csvs/products.csv spec/csvs/orders.csv spec/csvs/order_items.csv spec/csvs/output.csv)
    exec = Executor.new(
      Source::CSVSource.new,
      Target::CSVTarget.new(argv[4]),
      coupons_location: argv[0],
      products_location: argv[1],
      orders_location: argv[2],
      order_items_location: argv[3]
    )

    exec.run
    out = CSV.read('spec/csvs/output.csv')
    expect(out[0]).to match(%w(123 2250.0))
    expect(out[1]).to match(%w(234 216.75))
    expect(out[2]).to match(%w(345 314.5))
    expect(out[3]).to match(%w(456 427.5))
    expect(out[4]).to match(%w(567 525.0))
    expect(out[5]).to match(%w(678 2227.5))
  end
end
