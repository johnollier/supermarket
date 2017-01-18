class Item
  attr_accessor :code, :price
  def initialize(code, price)
    @code = code
    @price = price
  end


  def get_price
    @price
  end

end
