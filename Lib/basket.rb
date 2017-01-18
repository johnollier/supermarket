class Basket
  attr_accessor :basket
  def initialize
    @basket = { "FR1" => 0,
                "SR1" => 0,
                "CF1" => 0,
    }
  end

  def show_basket
    return "#{@basket} costs: £#{basket_total}"
  end

  def basket_total
    ((@basket["FR1"] * 311) + (@basket["SR1"] * 500) + (@basket["CF1"] * 1123)) / 100.00
  end

  def add(x)
    @basket[x] = @basket[x] + 1
  end

  def remove(x)
    @basket[x] = @basket[x] - 1 if @basket[x] > 0
  end

  def complete_purchase
    running_price = basket_total
    @basket = { "FR1" => 0,
                "SR1" => 0,
                "CF1" => 0,
    }
    return "That cost £#{running_price} and your basket is now empty"

  end

end

def start_checkout
  Basket.new
end
