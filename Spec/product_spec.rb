require 'product'

describe Product do
  it "has a code" do
    fruit_tea = Product.new('FR1','Fruit Tea', 311)
    expect(fruit_tea.code).to eq('FR1')
  end
  it "has a name" do
    fruit_tea = Product.new('FR1','Fruit Tea', 311)
    expect(fruit_tea.name).to eq('Fruit Tea')
  end
  it "has a price" do
    fruit_tea = Product.new('FR1','Fruit Tea', 311)
    expect(fruit_tea.price).to eq(311)
  end
end
