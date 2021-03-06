module Source
  require 'csv'
  #read cupons from csv location
  class CSVSource
    attr_accessor :location

    def initialize(location=nil)
      @location = location
    end 

    def populate_array(klass)
      array = []
      read(@location) do |row|
        array << klass.new(*row)
      end
      array 
    end

    def populate_hash(klass)
      hash = {}
      read(@location) do |row|
        hash[row[0].to_i] = klass.new(*row)
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
