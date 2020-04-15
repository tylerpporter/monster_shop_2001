require 'rails_helper'

describe ItemOrder, type: :model do
  describe "validations" do
    it { should validate_presence_of :order_id }
    it { should validate_presence_of :item_id }
    it { should validate_presence_of :price }
    it { should validate_presence_of :quantity }
  end

  describe "relationships" do
    it {should belong_to :item}
    it {should belong_to :order}
  end

  describe 'instance methods' do
    before(:each) do
      @user = User.create(name: "regular_test_user",
                         address: "1163 S Dudley St",
                         city: "Lakewood",
                         state: "CO",
                         zip: "80232",
                         email: "campryan@comcast.net",
                         password: "password",
                         password_confirmation: "password",
                         role: 0)
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @order1 = @user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      @item_order1 = @order1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
    end

    it 'subtotal' do
      expect(@item_order1.subtotal).to eq(200)
    end

    it 'replace_inventory' do
      expect(@item_order1.replace_inventory).to eq(14)
    end

    it "#not_enough_inventory?" do
      item_order2 = @order1.item_orders.create!(item: @tire, price: @tire.price, quantity: 13)
      expect(@item_order1.not_enough_inventory?).to eql(false)
      expect(item_order2.not_enough_inventory?).to eql(true)
    end
  end

end
