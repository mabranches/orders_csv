module Target 
  require 'csv'
  #read cupons from csv location
  class CSVTarget
    attr_accessor :location

    def initialize(location=nil)
      @location = location
    end 

    def write(array)
      CSV.open(@location, "wb") do |csv|
        array.each do |item|
          csv << item
        end
      end
    end
  end
end
