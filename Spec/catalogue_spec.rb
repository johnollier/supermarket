require 'catalogue'

describe Catalogue do
  describe '#initialize' do
    it "has all products" do
      catalogue = Catalogue.new
      # when testing methods test the data not a formatted message containing the data
      expect(catalogue.products_by_code['FR1'].code).to eq('FR1')
    end
  end
end
