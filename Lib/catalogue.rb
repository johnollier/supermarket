require 'sqlite3'
require_relative 'product'

class Catalogue

  attr_reader :products_by_code

  def initialize(db)

      product_table = db.get_first_value "SELECT name FROM sqlite_master WHERE type='table' AND name='product';"

      if product_table
        @products_by_code = {}
        product_results = db.execute "SELECT code, name, price FROM product;"
        product_results.each do |result|
          @products_by_code[result[0]] = Product.new(result[0], result[1], result[2])
        end
      else
        fruit_tea = Product.new('FR1', 'Fruit Tea', 311)
        strawberries = Product.new('SR1', 'Strawberries', 500)
        coffee = Product.new('CF1', 'Coffee', 1123)
        @products_by_code = {'FR1' => fruit_tea, 'SR1' => strawberries, 'CF1' => coffee}
        db.execute "CREATE TABLE IF NOT EXISTS product (code VARCHAR PRIMARY KEY, name VARCHAR NOT NULL, price INT NOT NULL);"
        @products_by_code.each do |product_code, product|
          db.execute "INSERT INTO product VALUES ('#{product_code}','#{product.name}', #{product.price.to_i} );"
        end

      end
  end

end