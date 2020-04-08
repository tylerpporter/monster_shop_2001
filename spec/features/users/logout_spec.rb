require 'rails_helper'

RSpec.describe 'As a registered user, merchant, or admin' do
  before(:each) do
    @mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @paper = @mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 25)
    @pencil = @mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 100)
  end

  context 'When I visit the logout path I am redirected to root' do
    it 'And I see a flash message that I am logged out' do
      user = User.create(name: "regular_test_user",
                         address: "1163 S Dudley St",
                         city: "Lakewood",
                         state: "CO",
                         zip: "80232",
                         email: "campryan@comcast.net",
                         password: "password",
                         password_confirmation: "password",
                         role: 0)

      visit '/login'

      within(".login_form") do
        fill_in :email, with: "campryan@comcast.net"
        fill_in :password, with: "password"
        click_button("Submit")
      end

      expect(current_path).to eql("/profile")

      visit "/items/#{@paper.id}"
      click_on "Add To Cart"
      visit "/items/#{@tire.id}"
      click_on "Add To Cart"
      visit "/items/#{@pencil.id}"
      click_on "Add To Cart"

      within(".topnav") do
        expect(page).to have_content("Cart: 3")
      end

      click_link 'Logout'

      within(".topnav") do
        expect(page).to have_content("Cart: 0")
      end
      expect(current_path).to eql("/")
      expect(page).to have_content("You are logged out")
    end
  end

  context 'When I visit the logout path I am redirected to root' do
    it 'And I see a flash message that I am logged out' do
      merchant = User.create(name: "merchant_test_user",
                             address: "222 Merchant St",
                             city: "Lakewood",
                             state: "WA",
                             zip: "80232",
                             email: "ryan@comcast.net",
                             password: "123password",
                             password_confirmation: "123password",
                             role: 1)
      visit '/login'

      within(".login_form") do
        fill_in :email, with: "ryan@comcast.net"
        fill_in :password, with: "123password"
        click_button("Submit")
      end

      expect(current_path).to eql("/merchant")
      visit "/items/#{@paper.id}"
      click_on "Add To Cart"
      visit "/items/#{@tire.id}"
      click_on "Add To Cart"
      visit "/items/#{@pencil.id}"
      click_on "Add To Cart"
      within(".topnav") do
        expect(page).to have_content("Cart: 3")
      end

      click_link 'Logout'

      within(".topnav") do
        expect(page).to have_content("Cart: 0")
      end
      expect(current_path).to eql("/")
      expect(page).to have_content("You are logged out")
    end


  end

  context 'When I visit the logout path I am redirected to root' do
    it 'And I see a flash message that I am logged out' do
      admin = User.create(name: "admin_test_user",
                          address: "1111 Admin St",
                          city: "Lakewood",
                          state: "CA",
                          zip: "80232",
                          email: "camp@example.com",
                          password: "password123",
                          password_confirmation: "password123",
                          role: 2)

      visit '/login'

      within(".login_form") do
        fill_in :email, with: "camp@example.com"
        fill_in :password, with: "password123"
        click_button("Submit")
      end

      click_link 'Logout'

      within(".topnav") do
        expect(page).to have_content("Cart: 0")
      end
      expect(current_path).to eql("/")
      expect(page).to have_content("You are logged out")
    end
  end
end
