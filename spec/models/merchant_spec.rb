require 'rails_helper'

describe Merchant, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_inclusion_of(:enabled?).in_array([true, false])}
  end

  describe "relationships" do
    it { should have_many :items}
    it { should have_many :merchant_employees }
    it { should have_many(:users).through(:merchant_employees) }
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
    end
    it 'no_orders' do
      expect(@meg.no_orders?).to eq(true)

      order_1 = @user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      item_order_1 = order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)

      expect(@meg.no_orders?).to eq(false)
    end

    it 'item_count' do
      chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 30, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)

      expect(@meg.item_count).to eq(2)
    end

    it 'average_item_price' do
      chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)

      expect(@meg.average_item_price).to eq(70)
    end

    it 'distinct_cities' do
      chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)
      order_1 = @user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      order_2 = @user.orders.create!(name: 'Brian', address: '123 Brian Ave', city: 'Denver', state: 'CO', zip: 17033)
      order_3 = @user.orders.create!(name: 'Dao', address: '123 Mike Ave', city: 'Denver', state: 'CO', zip: 17033)
      order_1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      order_2.item_orders.create!(item: chain, price: chain.price, quantity: 2)
      order_3.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)

      expect(@meg.distinct_cities).to include("Hershey")
      expect(@meg.distinct_cities).to include("Denver")
    end

    it 'can hire employees' do
      @meg.hire(@user)
      @user.reload

      expect(@user.role).to eq("merchant")
      expect(@user.merchant).to eq(@meg)
      expect(@meg.users).to eq([@user])
      expect(MerchantEmployee.last.merchant_id).to eq(@meg.id)
      expect(MerchantEmployee.last.user_id).to eq(@user.id)
    end

    it 'can return merchant pending orders' do
      twix = Merchant.create(name: "Twix's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      chain = twix.items.create(name: "Chain", description: "It'll never break!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)
      mchain = @meg.items.create(name: "MChain", description: "It'll never break!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)

      order1 = @user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      order2 = @user.orders.create!(name: 'Brian', address: '123 Brian Ave', city: 'Denver', state: 'CO', zip: 17033)
      order3 = @user.orders.create!(name: 'Dao', address: '123 Mike Ave', city: 'Denver', state: 'CO', zip: 17033)

      order1.item_orders.create!(item: @tire, price: @tire.price, quantity: 1)
      order2.item_orders.create!(item: chain, price: chain.price, quantity: 2)
      order3.item_orders.create!(item: mchain, price: mchain.price, quantity: 3)
      order3.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)

      expect(@meg.pending_orders).to eq([order1, order3])
    end

    it "#disable items" do
      mchain = @meg.items.create(name: "MChain", description: "It'll never break!", price: 40, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 22)

      expect(@tire.active?).to eql(true)
      expect(mchain.active?).to eql(true)

      @meg.disable_items

      expect(@tire.active?).to eql(false)
      expect(mchain.active?).to eql(false)
    end
  end
end
