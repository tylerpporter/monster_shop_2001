require 'rails_helper'

describe Item, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :description }
    it { should validate_presence_of :price }
    it { should validate_presence_of :image }
    it { should validate_presence_of :inventory }
    it { should validate_inclusion_of(:active?).in_array([true,false]) }
  end

  describe "relationships" do
    it {should belong_to :merchant}
    it {should have_many :reviews}
    it {should have_many :item_orders}
    it {should have_many(:orders).through(:item_orders)}
  end

  describe "instance methods" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @chain = @bike_shop.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)

      @review_1 = @chain.reviews.create(title: "Great place!", content: "They have great bike stuff and I'd recommend them to anyone.", rating: 5)
      @review_2 = @chain.reviews.create(title: "Cool shop!", content: "They have cool bike stuff and I'd recommend them to anyone.", rating: 4)
      @review_3 = @chain.reviews.create(title: "Meh place", content: "They have meh bike stuff and I probably won't come back", rating: 1)
      @review_4 = @chain.reviews.create(title: "Not too impressed", content: "v basic bike shop", rating: 2)
      @review_5 = @chain.reviews.create(title: "Okay place :/", content: "Brian's cool and all but just an okay selection of items", rating: 3)
    end

    it "calculate average review" do
      expect(@chain.average_review).to eq(3.0)
    end

    it "sorts reviews" do
      top_three = @chain.sorted_reviews(3,:desc)
      bottom_three = @chain.sorted_reviews(3,:asc)

      expect(top_three).to eq([@review_1,@review_2,@review_5])
      expect(bottom_three).to eq([@review_3,@review_4,@review_5])
    end

    it 'no orders' do
      expect(@chain.no_orders?).to eq(true)
      order = Order.create(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033)
      order.item_orders.create(item: @chain, price: @chain.price, quantity: 2)
      expect(@chain.no_orders?).to eq(false)
    end
  end

  describe "class methods" do
    before(:each) do
      @bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      @bike_item1 = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @bike_item2 = @bike_shop.items.create(name: "Entity MH15 Mountain Bike Helmet", description: "Description for bike item 2", price: 30, image: "https://www.bikesonline.com/assets/full/S00147.jpg?1554705703", inventory: 50)
      @bike_item3 = @bike_shop.items.create(active?: false, name: "Entity CH15 Road/Mountain Bike Helmet", description: "Description for bike item 3", price: 20, image: "https://www.bikesonline.com/assets/full/S00144.jpg?1554705716", inventory: 40)
      @bike_item4 = @bike_shop.items.create(active?: false, name: "Entity MG15 Long Finger Gel Pad Cycling Gloves", description: "Amazing gloves.", price: 13, image: "https://www.bikesonline.com/assets/full/S00150.jpg?1554705597", inventory: 200)
      @bike_item5 = @bike_shop.items.create(name: "DHaRCO Mens Gloves", description: "Description for bike item 5", price: 23, image: "https://www.bikesonline.com/assets/full/S00258.jpg?1557515068", inventory: 25)
      @bike_item6 = @bike_shop.items.create(active?: false, name: "bike item 6", description: "Description for bike item 6", price: 23, image: "https://www.bikesonline.com/assets/full/S00258.jpg?1557515068", inventory: 25)

      @order1 = Order.create(name: "Ryan", address: "123 S South St", city: "Whatatown", state: "CA", zip: 98765)

      ItemOrder.create(item: @bike_item1, order: @order1, price: @bike_item1.price, quantity: 1200)
      ItemOrder.create(item: @bike_item2, order: @order1, price: @bike_item2.price, quantity: 1100)
      ItemOrder.create(item: @bike_item3, order: @order1, price: @bike_item3.price, quantity: 1500)
      ItemOrder.create(item: @bike_item4, order: @order1, price: @bike_item4.price, quantity: 600)
      ItemOrder.create(item: @bike_item5, order: @order1, price: @bike_item5.price, quantity: 300)
      ItemOrder.create(item: @bike_item6, order: @order1, price: @bike_item6.price, quantity: 2000)
    end

    it "can return a collection of all active items." do
      expect(Item.all_active).to contain_exactly( @bike_item2, @bike_item1, @bike_item5)
    end

    it "can return the 5 most ordered items" do
      expect(Item.five_most_poplular).to eql([@bike_item6, @bike_item3, @bike_item1, @bike_item2, @bike_item4,])
    end
  end

end
