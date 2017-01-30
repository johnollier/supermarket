require 'catalogue'

class MockDB
  def execute(s)
    # do nothing
  end

  def get_first_value(s)
    return nil
  end
end

db = MockDB.new

describe Catalogue do
  describe '#initialize' do
    it "has all products" do
      catalogue = Catalogue.new(db)
      # when testing methods test the data not a formatted message containing the data
      expect(catalogue.products_by_code['FR1'].code).to eq('FR1')
    end
  end
end
