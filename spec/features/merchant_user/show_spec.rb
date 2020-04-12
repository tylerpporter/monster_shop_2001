require 'rails_helper'

RSpec.describe 'As a merchant employee' do
  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)

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

    visit '/login'

    within(".login_form") do
      fill_in :email, with: "bob@example.com"
      fill_in :password, with: "password"
      click_button("Submit")
    end
  end

  describe 'when I visit my merchant dashboard' do
    it 'I see the name and full address of the merchant I work for' do

      expect(page).to have_content(@bike_shop.name)
      expect(page).to have_content(@bike_shop.address)
      expect(page).to have_content("#{@bike_shop.city}, #{@bike_shop.state} #{@bike_shop.zip}")
    end
  end
end
