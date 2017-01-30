require 'mock_db'
require 'multiple_purchase_free_discount'

db = MockDb.new

describe MultiplePurchaseFreeDiscount do
  catalogue = Catalogue.new(db)
  describe '#calculate_discount' do
    it "is zero under threshold" do
      rule = MultiplePurchaseFreeDiscount.new(2, 'FR1')
      purchases = {'FR1' => 1, 'SR1' => 0, 'CF1' => 0}
      discount = rule.calculate_discount(catalogue, purchases)
      expect(discount).to eq(0)
    end
    it "is same as price on threshold" do
      rule = MultiplePurchaseFreeDiscount.new(2, 'FR1')
      purchases = {'FR1' => 2, 'SR1' => 0, 'CF1' => 0}
      discount = rule.calculate_discount(catalogue, purchases)
      expect(discount).to eq(311)
    end
    it "is same as price just over threshold" do
      rule = MultiplePurchaseFreeDiscount.new(2, 'FR1')
      purchases = {'FR1' => 3, 'SR1' => 0, 'CF1' => 0}
      discount = rule.calculate_discount(catalogue, purchases)
      expect(discount).to eq(311)
    end
    it "is twice price for twice threshold" do
      rule = MultiplePurchaseFreeDiscount.new(2, 'FR1')
      purchases = {'FR1' => 4, 'SR1' => 0, 'CF1' => 0}
      discount = rule.calculate_discount(catalogue, purchases)
      expect(discount).to eq(622)
    end
  end
end
