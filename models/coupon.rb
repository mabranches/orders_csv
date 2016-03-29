class Coupon
  attr_accessor :id, :value, :type, :expires, :count
  ABSOLUTE = "absolute"
  PERCENT = "percent"
  def initialize(id, value, type, expires, count)
    @id = id.to_i
    @value = value.to_f
    @type = type
    @expires = Date.strptime(expires, '%Y/%m/%d')
    @count = count.to_i
  end

  def valid?
    count > 0 && @expires >= Date.today
  end

  def mark_used
    @count -= 1
  end
end
