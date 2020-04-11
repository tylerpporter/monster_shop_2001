require 'rails_helper'

RSpec.describe 'As a merchant employee' do
  before(:each) do
    @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 23137)

    @merchant_user = User.create(name: "Bob",
                                 address: "123 Glorious Way",
                                 city: "Stupendous",
                                 state: "SomeState",
                                 zip: '80122',
                                 email: "bob@example.com",
                                 password: "password",
                                 password_confirmation: "password",
                                 role: 1)
binding.pry
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)

    visit '/login'

    within(".login_form") do
      fill_in :email, with: "bob@example.com"
      fill_in :password, with: "password"
      click_button("Submit")
    end
  end

  describe 'when I visit my merchant dashboard' do
    it 'I see the name and full address of the merchant I work for' do

      visit "/"
    end
  end

end
