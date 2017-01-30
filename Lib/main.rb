require './basket'
require './catalogue'

def print_message(lines)
  lines.each { |line| puts line }
end

begin
  db = SQLite3::Database.new 'supermarket.db'

  puts "Welcome to the GDS supermarket"

  finish = false

  catalogue = Catalogue.new(db)
  basket = Basket.new(catalogue)

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