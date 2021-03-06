require 'takeaway'

describe Takeaway do
  subject(:takeaway) { described_class.new(menu: menu, order: order, sms: sms, config: {}) }

  let(:menu) { double :menu, print_menu: printed_menu }
  let(:printed_menu) { "Menu" }
  let(:order) { instance_double("Order", total: 18.49) }
  let(:sms) { instance_double("SMS", deliver: nil) }
  let(:dishes) { { pizza: 2, pasta: 1 } }
  it 'prints the menu from the menu class with the dishes and prices' do
    expect(takeaway.print_menu).to eq(printed_menu)
  end
  it 'can order some number of several available dishes' do
    expect(order).to receive(:add).twice
    takeaway.place_order(dishes)
  end
  it 'knows the order total' do
    allow(order).to receive(:add)
    total = takeaway.place_order(dishes)
    expect(total).to eq(18.49)
  end

  it 'sends an sms when the order is placed' do
    allow(order).to receive(:add)
    allow(sms).to receive(:deliver)
    takeaway.place_order(dishes)
  end
end
