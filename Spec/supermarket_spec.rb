require 'basket'

describe Basket do
  it "Opens a new basket, can add an item to it and calulate price" do
    x = start_checkout
    x.add("FR1")
    expect(x.show_basket).to eq('{"FR1"=>1, "SR1"=>0, "CF1"=>0} costs: £3.11')
  end

  it "Opens a new basket, adds some items, removes others and calculates price" do
    x = start_checkout
    x.add("FR1")
    x.add("FR1")
    x.add("SR1")
    x.remove("FR1")
    expect(x.show_basket).to eq('{"FR1"=>1, "SR1"=>1, "CF1"=>0} costs: £8.11')
  end

  it "Opens a new basket, adds stuff, removes stuff, checks out and empties basket" do
    x = start_checkout
    x.add("FR1")
    x.add("FR1")
    x.add("SR1")
    x.remove("FR1")
    expect(x.complete_purchase).to eq('That cost £8.11 and your basket is now empty')
  end



end
