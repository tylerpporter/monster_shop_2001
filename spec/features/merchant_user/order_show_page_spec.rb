require "rails_helper"

RSpec.describe "As a merchant employee", type: :feature do
  describe "when I visit an order show page from my dashboard" do
    before :each do
      @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)
      @bike_item1 = @bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @bike_item2 = @bike_shop.items.create(name: "Entity MH15 Mountain Bike Helmet", description: "The Entity MH15 MTB Helmet builds on current trends to deliver a helmet that is low profile and yet also provides additional protection to the base of the head. Available in matt base colors - the helmets feature some of the best helmet technology in the market today. ", price: 30, image: "https://www.bikesonline.com/assets/full/S00147.jpg?1554705703", inventory: 50)
      @bike_item3 = @bike_shop.items.create(name: "Entity CH15 Road/Mountain Bike Helmet", description: "The Entity CH15 Recreational Helmet is the stylish entry point into bicycle helmets. With solid gloss base colors treated with fine details, the helmets will sit as comfortably on your head as they do in the pack. ", price: 20, image: "https://www.bikesonline.com/assets/full/S00144.jpg?1554705716", inventory: 40)

      @art_shop = Merchant.create(name: "Ryan's Art Shop", address: '125 Art Ave.', city: 'Littleton', state: 'CO', zip: 80232)
      @art_item1 = @art_shop.items.create(name: "Art Item 1", description: "Description for Art Item 1", price: 5, image: "https://artfulparent-wpengine.netdna-ssl.com/wp-content/uploads/2014/01/81tP1TmUQL._SL1500_-300x300.jpg", active?: true, inventory: 100)

      @shopper = User.create(name: "@shopper_test_user",
                            address: "1163 S Dudley St",
                            city: "Lakewood",
                            state: "CO",
                            zip: "80232",
                            email: "campryan@comcast.net",
                            password: "password",
                            password_confirmation: "password",
                            role: 0)

      @order1 = @shopper.orders.create(name: "Ryan", address: "123 S South St", city: "Whatatown", state: "CA", zip: 98765)
      @item_order1 = @order1.item_orders.create(item: @art_item1, price: @art_item1.price, quantity: 2)
      @item_order2 = @order1.item_orders.create(item: @bike_item1, price: @bike_item1.price, quantity: 2)
      @item_order3 = @order1.item_orders.create(item: @bike_item2, price: @bike_item2.price, quantity: 3)

      @order2 = @shopper.orders.create(name: "Test", address: "123 S South St", city: "Whatatown", state: "CA", zip: 98765)
      @item_order4 = @order2.item_orders.create(item: @bike_item1, price: @bike_item1.price, quantity: 5)
      @item_order5 = @order2.item_orders.create(item: @bike_item2, price: @bike_item2.price, quantity: 5)
      @item_order6 = @order2.item_orders.create(item: @art_item1, price: @art_item1.price, quantity: 4)

      @shop_employee = User.create(name: "Bob",
                                   address: "123 Glorious Way",
                                   city: "Stuck",
                                   state: "SomeState",
                                   zip: '80122',
                                   email: "bob@example.com",
                                   password: "password",
                                   password_confirmation: "password",
                                   role: 0)

      @bike_shop.hire(@shop_employee)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@shop_employee)

    end

    it "I can see only the items on the order from my merchant" do
      visit "/merchant"

      within("#order-#{@order2.id}") do
        click_link "#{@order2.id}"
      end

      expect(page).to have_current_path("/merchant/orders/#{@order2.id}")

      within "#customer-details" do
        expect(page).to have_content(@shopper.name)
        expect(page).to have_content(@shopper.address)
        expect(page).to have_content(@shopper.city)
        expect(page).to have_content(@shopper.state)
        expect(page).to have_content(@shopper.zip)
      end

      within "#item-#{@bike_item1.id}" do
        expect(page).to have_link(@bike_item1.name)
        expect(page).to have_css("img[src*='#{@bike_item1.image}']")
        expect(page).to have_content(@bike_item1.price)
        expect(page).to have_content("Quantity: #{@item_order4.quantity}")
      end


      within "#item-#{@bike_item2.id}" do
        expect(page).to have_link(@bike_item2.name)
        expect(page).to have_css("img[src*='#{@bike_item2.image}']")
        expect(page).to have_content(@bike_item2.price)
        expect(page).to have_content("Quantity: #{@item_order5.quantity}")
      end

      expect(page).to_not have_css("#item-#{@art_item1.id}")

    end

    it 'I can see a link to fulfull the item in the order' do
      visit "/merchant/orders/#{@order1.id}"

      expect(@item_order2.status).to eq("unfulfilled")

      within("#item-#{@item_order2.item_id}") do
        click_link 'fulfill'
      end

      @item_order2.reload

      expect(@item_order2.status).to eq("fulfilled")

      expect(current_path).to eq("/merchant/orders/#{@order1.id}")

      within("#item-#{@item_order2.item_id}") do
        expect(page).to have_content('Item Fulfilled')
        expect(page).to have_no_link('fulfill')
      end

      expect(page).to have_content("#{@item_order2.item.name} has been fulfilled")
    end
  end
end
