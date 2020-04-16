require "rails_helper"

RSpec.describe "As an admin user" do
  before(:each) do
    @admin = User.create( name: "admin",
                          address: "1163 S Dudley St",
                          city: "Lakewood",
                          state: "CO",
                          zip: "80232",
                          email: "ryan@comcast.net",
                          password: "password",
                          password_confirmation: "password",
                          role: 2 )
    @merchant1 = Merchant.create(name: "Merchant1", address: '123 Bike Rd.', city: 'Whichita', state: 'VA', zip: 23137)
    @merchant2 = Merchant.create(name: "Merchant2", address: '123 Scooter Rd.', city: 'Whachatown', state: 'VA', zip: 23137)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
  end

  context "In the admin merchant show page"
  it "I can see everything a merchant would see." do
  item1 = @merchant1.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
  item2 = @merchant1.items.create(name: "Entity MH15 Mountain Bike Helmet", description: "The Entity MH15 MTB Helmet builds on current trends to deliver a helmet that is low profile and yet also provides additional protection to the base of the head. Available in matt base colors - the helmets feature some of the best helmet technology in the market today. ", price: 30, image: "https://www.bikesonline.com/assets/full/S00147.jpg?1554705703", inventory: 50)

  shopper = User.create(name: "@shopper_test_user",
                        address: "1163 S Dudley St",
                        city: "Lakewood",
                        state: "CO",
                        zip: "80232",
                        email: "campryan@comcast.net",
                        password: "password",
                        password_confirmation: "password",
                        role: 0)

    order1 = shopper.orders.create(name: "Ryan", address: "123 S South St", city: "Whatatown", state: "CA", zip: 98765)

    order1.item_orders.create(item: item1, price: item1.price, quantity: 2)
    order1.item_orders.create(item: item2, price: item2.price, quantity: 3)
    visit "/admin/merchants/#{@merchant1.id}"

    within("#order-#{order1.id}") do
      expect(page).to have_link("#{order1.id}")
      expect(page).to have_content(order1.created_at)
      expect(page).to have_content(5)
      expect(page).to have_content(290)
    end
    within(".dashboard-links") do
      expect(page).to have_link("My Items")
    end
  end
end
