require 'order'
require 'menu'

describe Order do
  subject(:order) { described_class.new(menu) }
  let(:menu) { instance_double("Menu") }
  let(:dishes) do
    {
    pizza: 2,
    pasta: 1
    }
  end

  before do
    allow(menu).to receive(:available?).with(:pizza).and_return true
    allow(menu).to receive(:available?).with(:pasta).and_return true
    allow(menu).to receive(:price).with(:pizza).and_return 9.99
    allow(menu).to receive(:price).with(:pasta).and_return 8.50
  end
  it 'selects several dishes from menu' do
    order.add(:pizza, 2)
    order.add(:pasta, 1)
    expect(order.dishes).to eq(dishes)
  end

  it 'does not allow items to be added that are not on the menu' do
    allow(menu).to receive(:available?).with(:chicken).and_return false
    expect { order.add(:chicken, 2) }.to raise_error("Chicken is not on the menu")
  end

  it 'returns the total price of the dishes' do
    order.add(:pizza, 2)
    order.add(:pasta, 1)
    total = 28.48
    expect(order.total).to eq(total)
  end
end
