module Source
  require 'csv'
  #read cupons from csv location
  class CSVsource
   attr_accessor :location

   def initialize(location)
     @location = location
   end 

   def populate_array
     array = []
     read(@location) do |row|
       array << klass.new(*row)
     end
     hash   
   end

   def populate_hash
     hash = {}
     read(@location) do |row|
       hash[row[0]] = klass.new(*row)
     end
     hash
   end

   private

   def read(location)  
     CSV.foreach(location) do |row|
       yield row if block_given?
     end
   end

 end
end
