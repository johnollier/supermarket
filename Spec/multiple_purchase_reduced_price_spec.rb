require 'mock_db'
require 'multiple_purchase_reduced_price_discount'

db = MockDb.new

describe MultiplePurchaseReducedPriceDiscount do
  catalogue = Catalogue.new(db)
  describe '#calculate_discount' do
    it "is zero under threshold" do
      rule = MultiplePurchaseReducedPriceDiscount.new(3, 'SR1', 450)
      purchases = {'SR1' => 2, 'FR1' => 0, 'CF1' => 0 }
      discount = rule.calculate_discount(catalogue, purchases)
      expect(discount).to eq(0)
    end
    it "is difference between prices on threshold" do
      rule = MultiplePurchaseReducedPriceDiscount.new(3, 'SR1', 450)
      purchases = {'SR1' => 3, 'FR1' => 0, 'CF1' => 0}
      discount = rule.calculate_discount(catalogue, purchases)
      expect(discount).to eq(150)
    end
    it "is difference between prices over threshold" do
      rule = MultiplePurchaseReducedPriceDiscount.new(3, 'SR1', 450)
      purchases = {'SR1' => 4, 'FR1' => 0, 'CF1' => 0}
      discount = rule.calculate_discount(catalogue, purchases)
      expect(discount).to eq(200)
    end
    it "is zero for other product" do
      rule = MultiplePurchaseReducedPriceDiscount.new(3, 'SR1', 450)
      purchases = {'SR1' => 0, 'FR1' => 1, 'CF1' => 2}
      discount = rule.calculate_discount(catalogue, purchases)
      expect(discount).to eq(0)
    end
  end
end
