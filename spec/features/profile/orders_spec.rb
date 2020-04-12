require 'rails_helper'

RSpec.describe 'As a registered user' do
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
    @meg = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @item2 = @meg.items.create(name: "Fish", description: "They'll never pop!", price: 50, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

    @order1 = @user.orders.create!(name: 'Meg', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218)
    @item_order1 = @order1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
    @item_order2 = @order1.item_orders.create!(item: @item2, price: @item2.price, quantity: 3)

    visit '/login'

    within(".login_form") do
      fill_in :email, with: "campryan@comcast.net"
      fill_in :password, with: "password"
      click_button("Submit")
    end
  end

  context "When I have an order(s) placed in the system" do
    it "I can click my orders and it takes me to /profile/orders" do
      visit profile_path

      click_link 'My Orders'

      expect(current_path).to eq('/profile/orders')
    end
    it "I see a list of all orders including all of their info" do
      visit '/profile/orders'

      within "#order-#{@order1.id}" do
        expect(page).to have_link(@order1.id)
        expect(page).to have_content("Created At: #{@order1.created_at}")
        expect(page).to have_content("Updated At: #{@order1.updated_at}")
        expect(page).to have_content("Status: #{@order1.status}")
        expect(page).to have_content("Total Quantity Ordered: 5")
        expect(page).to have_content("Grand Total: 350")
      end
    end
    it "I see a link to an order show page" do
      visit '/profile/orders'

      within "#order-#{@order1.id}" do
        click_link @order1.id
      end
      expect(current_path).to eq("/profile/orders/#{@order1.id}")
    end
    describe "Profile order show page"
    it "I see all of that order's info" do
      visit "profile/orders/#{@order1.id}"

      expect(page).to have_content(@order1.id)
      expect(page).to have_content("Created At: #{@order1.created_at}")
      expect(page).to have_content("Updated At: #{@order1.updated_at}")
      expect(page).to have_content("Status: #{@order1.status}")
      expect(page).to have_content("Total Quantity Ordered: 5")
      expect(page).to have_content("Grand Total: 350")
      within "#item-#{@tire.id}" do
        expect(page).to have_content(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_css("img[src='#{@tire.image}']")
        expect(page).to have_content("Quantity: 2")
        expect(page).to have_content("Price: $#{@tire.price}.00")
        expect(page).to have_content("Subtotal: $200.00")
      end
      within "#item-#{@item2.id}" do
        expect(page).to have_content(@item2.name)
        expect(page).to have_content(@item2.description)
        expect(page).to have_css("img[src='#{@item2.image}']")
        expect(page).to have_content("Quantity: 3")
        expect(page).to have_content("Price: $#{@item2.price}.00")
        expect(page).to have_content("Subtotal: $150.00")
      end
    end
    it "I see a link to cancel the order" do
      visit "profile/orders/#{@order1.id}"

      click_link "Cancel Order"

      order = Order.find(@order1.id)
      expected = order.item_orders.all? {|item_order| item_order.status == "unfulfilled"}
      expect(expected).to eq(true)
      expect(order.item_orders.first.item.inventory).to eq(14)
      expect(order.status).to eq("cancelled")
      expect(current_path).to eq('/profile')
      expect(page).to have_content("Your order (Order ID: #{@order1.id}) has been cancelled.")
    end
  end
end
