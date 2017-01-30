require 'basket'
require 'catalogue'

# here's a simple mock class, but for anything more complex use a mocking framework
class MockDB
  def execute(s)
    # do nothing
  end

  def get_first_value(s)
    nil
  end
end

db = MockDB.new

describe Basket do
  catalogue = Catalogue.new(db)
  describe '#initialize' do
    it "is empty initially" do
      basket = Basket.new(catalogue)
      # when testing methods test the data not a formatted message containing the data
      expect(basket.purchases['FR1']).to eq(0)
      expect(basket.purchases['SR1']).to eq(0)
      expect(basket.purchases['CF1']).to eq(0)
    end
  end
  describe '#add' do
    it "can add a valid item" do
      basket = Basket.new(catalogue)
      basket.add("FR1")
      expect(basket.purchases['FR1']).to eq(1)
      expect(basket.purchases['SR1']).to eq(0)
      expect(basket.purchases['CF1']).to eq(0)
    end
    it "will not add an invalid item" do
      basket = Basket.new(catalogue)
      basket.add("ZZZ")
      expect(basket.purchases['FR1']).to eq(0)
      expect(basket.purchases['SR1']).to eq(0)
      expect(basket.purchases['CF1']).to eq(0)
    end
  end
  describe '#remove' do
    it "can remove a valid item if present" do
      basket = Basket.new(catalogue)
      basket.add("FR1")
      basket.add("FR1")
      basket.remove("FR1")
      expect(basket.purchases['FR1']).to eq(1)
      expect(basket.purchases['SR1']).to eq(0)
      expect(basket.purchases['CF1']).to eq(0)
    end
    it "will not remove an invalid item" do
      basket = Basket.new(catalogue)
      basket.remove("ZZZ")
      expect(basket.purchases['FR1']).to eq(0)
      expect(basket.purchases['SR1']).to eq(0)
      expect(basket.purchases['CF1']).to eq(0)
    end
  end
  describe '#total' do
    it "will be zero initially" do
      basket = Basket.new(catalogue)
      expect(basket.total).to eq(0)
    end
    it "will calculate the running total" do
      basket = Basket.new(catalogue)
      basket.add("FR1")
      basket.add("FR1")
      basket.add("CF1")
      expect(basket.total).to eq(1745)
    end
  end
  describe '#show' do
    it "will show product names and quantities" do
      basket = Basket.new(catalogue)
      basket.add("FR1")
      basket.add("FR1")
      basket.add("CF1")
      message = basket.show
      expect(message[0]).to eq("2 x Fruit Tea £6.22")
      expect(message[1]).to eq("1 x Coffee £11.23")
    end
  end
end

