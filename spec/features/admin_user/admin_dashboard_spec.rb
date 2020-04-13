require "rails_helper"

RSpec.describe "As an admin" do
  before :each do
    @admin_user = User.create(name: "Bob",
                               address: "123 Glorious Way",
                               city: "Stupendous",
                               state: "SomeState",
                               zip: '80122',
                               email: "bob@example.com",
                               password: "password",
                               password_confirmation: "password",
                               role: 2)

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

    @order2 = @user.orders.create!(name: 'Meg', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218)
    @item_order1 = @order1.item_orders.create!(item: @tire, price: @tire.price, quantity: 4)
    @item_order2 = @order1.item_orders.create!(item: @item2, price: @item2.price, quantity: 2)


    visit '/login'

    within(".login_form") do
      fill_in :email, with: "bob@example.com"
      fill_in :password, with: "password"
      click_button("Submit")
    end
  end

  describe "when I visit my admin dashboard," do
    it "then I see all the orders in the system" do

      within "#order-#{@order1.id}" do
        expect(page).to have_link(@order1.user.name)
        expect(page).to have_content(@order1.id)
        expect(page).to have_content(@order1.created_at)
      end

      within "#order-#{@order2.id}" do
        expect(page).to have_link(@order2.user.name)
        expect(page).to have_content(@order2.id)
        expect(page).to have_content(@order2.created_at)
      end
    end

    it "user name link goes to admin view of user profile" do
      within "#order-#{@order1.id}" do
        click_link(@order1.user.name)
      end
      expect(page).to have_current_path("/admin/users/#{@order1.user.id}")
    end
  end
end

# User Story 32, Admin can see all orders
#
# As an admin user
# When I visit my admin dashboard ("/admin")
# Then I see all orders in the system.
# For each order I see the following information:
#
# - user who placed the order, which links to admin view of user profile
# - order id
# - date the order was created
#
# Orders are sorted by "status" in this order:
#
# - packaged
# - pending
# - shipped
# - cancelled
