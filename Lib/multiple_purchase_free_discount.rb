class MultiplePurchaseFreeDiscount

  def initialize(multiple, product_code)
    @multiple = multiple
    @product_code = product_code
  end

  def product_code
    @product_code
  end

  def calculate_discount(catalogue, purchases)
    product_price = catalogue.products_by_code[@product_code].price
    product_price * (purchases[@product_code] / 2)
  end

  def discount_line( discount )
    "Buy #{@multiple} get one free discount £#{discount}"
  end

end