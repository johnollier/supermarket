class Basket
  attr_reader :purchases

  def initialize(catalogue)
    # the class is called basket, lets think of a different descriptive name
    @purchases = Hash.new
    @catalogue = catalogue
    @catalogue.products_by_code.each_key { |p_code| @purchases[p_code] = 0 }
  end

  def show_basket
    # #{@basket} will call to_s method of Basket
  end

  def total
    running_total = 0
    @purchases.each do |code, quantity|
      running_total = running_total + quantity * @catalogue.products_by_code[code].price
    end
    return running_total
  end

  # give our parameter a descriptive name
  def add(product_code)
    # what if the user passes a non existant product code
    if @purchases.key?(product_code)
      @purchases[product_code] = @purchases[product_code] + 1
    else
      # TODO can do better than this
      print("Error: no product with code: #{product_code}")
    end
  end

  def remove(product_code)
    if @purchases.key?(product_code)
      if purchases[product_code] > 0
        purchases[product_code] = purchases[product_code] - 1
      else
        print("Warning: no product with code #{product_code} in basket")
      end
    else
      # TODO can do better than this
      print("Error: no product with code: #{product_code}")
    end
  end

end
