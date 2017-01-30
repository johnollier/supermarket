require './basket'
require './catalogue'
require './multiple_purchase_free_discount'
require './multiple_purchase_reduced_price_discount'

def print_message(lines)
  lines.each { |line| puts line }
end

begin
  db = SQLite3::Database.new 'supermarket.db'

  puts "Welcome to the GDS supermarket"

  finish = false

  catalogue = Catalogue.new(db)
  buy_fruit_tea_offer = MultiplePurchaseFreeDiscount.new(2, 'FR1')
  reduced_price_strawbs_offer = MultiplePurchaseReducedPriceDiscount.new(3, 'SR1', 450)
  discount_rules = [buy_fruit_tea_offer, reduced_price_strawbs_offer]
  basket = Basket.new(catalogue, discount_rules)

  while !finish
    puts "Please enter command from: add [product code], remove [product_code], checkout"
    command = gets.strip
    if command == 'checkout'
      puts basket.show
      finish = true
    elsif command =~ /add \w{3}/
      product_code = command.split(" ")[1]
      puts basket.add(product_code)
    elsif command =~ /remove \w{3}/
      product_code = command.split(" ")[1]
      puts basket.remove(product_code)
    else
      puts "You did not enter a valid command!"
    end

  end

rescue SQLite3::Exception => e
  puts e
ensure
  db.close if db
end