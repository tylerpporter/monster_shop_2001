require "rails_helper"

RSpec.describe "As a registered user when i visit /profile" do
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

  context 'Then I see all of my profile data on the page except my password' do
    it 'And I see a link to edit my profile data' do
      expect(current_path).to eql("/profile")
      expect(page).to have_content("You are logged in")

      expect(page).to have_content("regular_test_user")
      expect(page).to have_content("1163 S Dudley St")
      expect(page).to have_content("Lakewood")
      expect(page).to have_content("CO")
      expect(page).to have_content("80232")
      expect(page).to have_content("campryan@comcast.net")

      page.has_link?("Edit Profile")
    end
  end

  context "I have and order(s) placed in the system" do
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
        expect(page).to have_content("Total Quantity Ordered: 5") #sum of all item_order quantities
        expect(page).to have_content("Grand Total: 350") #grand total
      end

    end
  end

end
