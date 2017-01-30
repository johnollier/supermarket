class MultiplePurchaseReducedPriceDiscount

  def initialize(multiple, product_code, reduced_price)
    @multiple = multiple
    @product_code = product_code
    @reduced_price = reduced_price
  end

  def product_code
    @product_code
  end

  def calculate_discount(catalogue, purchases)
    product_price = catalogue.products_by_code[@product_code].price
    if purchases[@product_code] >= @multiple
      (product_price - @reduced_price) * purchases[@product_code]
    else
      0
    end

  end

  def discount_line(discount)
    "Buy #{@multiple} get reduced price discount £#{discount}"
  end

end