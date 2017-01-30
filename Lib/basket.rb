class Basket
  attr_reader :purchases

  def initialize(catalogue, discount_rules)
    # the class is called basket, lets think of a different descriptive name
    @purchases = Hash.new
    @catalogue = catalogue
    @catalogue.products_by_code.each_key { |p_code| @purchases[p_code] = 0 }
    @discount_rules = discount_rules
  end

  def show
    # #{@basket} will call to_s method of Basket - that's good for debugging, but not user friendly.
    message_lines = Array.new
    @purchases.each do |code, quantity|
      if quantity > 0
        product = @catalogue.products_by_code[code]
        price = product.price * quantity
        message_lines << checkout_line(product.name, quantity, price)
      end
    end
    subtotal = total
    message_lines << total_line(subtotal)
    @discount_rules.each do |discount_rule|
      discount = discount_rule.calculate_discount(@catalogue, @purchases)
      if discount > 0
        subtotal = subtotal - discount
        message_lines << discount_rule.discount_line( format_price( discount ) )
      end
    end
    message_lines << total_line(subtotal)
    message_lines
  end

  def total
    running_total = 0
    @purchases.each do |code, quantity|
      running_total = running_total + quantity * @catalogue.products_by_code[code].price
    end
    running_total
  end

  # give our parameter a descriptive name
  def add(product_code)
    # what if the user passes a non existant product code
    if @purchases.key?(product_code)
      @purchases[product_code] = @purchases[product_code] + 1
      product = @catalogue.products_by_code[product_code]
      return add_line(product.name, product.price)
    else
      return "Error: no product with code: #{product_code}"
    end
  end

  def remove(product_code)
    if @purchases.key?(product_code)
      if purchases[product_code] > 0
        purchases[product_code] = purchases[product_code] - 1
        product = @catalogue.products_by_code[product_code]
        return removed_line(product.name)
      else
        return "Warning: no product with code #{product_code} in basket"
      end
    else
      return "Error: no product with code: #{product_code} in catalogue"
    end
  end

  private

  def format_price(price_in_p)
    price_in_pounds = price_in_p / 100.0
    if price_in_p % 10 == 0
      price_in_pounds.to_s + '0'
    else
      price_in_pounds.to_s
    end
  end

  def checkout_line(name, quantity, price)
    price_in_pounds = format_price(price)
    "#{quantity} x #{name} £#{price_in_pounds}"
  end

  def add_line(name, price)
    price_in_pounds = format_price(price)
    "Added #{name} £#{price_in_pounds}"
  end

  def removed_line(name)
    "Removed #{name}"
  end

  def total_line(total_pence)
    total = format_price(total_pence)
    "Total #{total}"
  end

end
