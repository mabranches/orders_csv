#!/usr/bin/env ruby

Dir["./lib/*"].each {|file| require file }
Dir["./models/*"].each {|file| require file }
require 'byebug'

if ARGV.length != 5
  puts '5 arguments are expected'
  exit 1
end

exec = Executor.new(
  Source::CSVSource.new,
  Target::CSVTarget.new(ARGV[4]),
  coupons_location: ARGV[0],
  products_location: ARGV[1],
  orders_location: ARGV[2],
  order_items_location: ARGV[3]
)
exec.run
