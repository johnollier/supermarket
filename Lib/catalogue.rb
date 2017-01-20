require 'product'

class Catalogue

  attr_reader :products_by_code

  def initialize()
    fruit_tea = Product.new('FR1','Fruit Tea', 311)
    strawberries = Product.new('SR1','Strawberries', 500)
    coffee = Product.new('CF1','Coffee', 1123)
    @products_by_code = {'FR1' => fruit_tea, 'SR1' => strawberries, 'CF1' => coffee}
  end

end