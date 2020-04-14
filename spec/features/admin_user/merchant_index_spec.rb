require "rails_helper"

RSpec.describe "As an admin level user." do
  describe "When I visit a admin namespaced merchant index page." do
    before(:each) do
      @admin_user = User.create!(name: "Bob",
                                 address: "123 Glorious Way",
                                 city: "Stupendous",
                                 state: "SomeState",
                                 zip: '80122',
                                 email: "bob@example.com",
                                 password: "password",
                                 password_confirmation: "password",
                                 role: 2)
     @merchant1 = Merchant.create!(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
     @merchant2 = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
     @merchant3 = Merchant.create!(name: "Ryan's Art Shop", address: '125 Art Ave.', city: 'Littleton', state: 'CO', zip: 80232, enabled?: false)
    end

    it "I can see 'disable' button next to all enabled merchants" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
      visit "/admin/merchants"

      within("#merchant-#{@merchant1.id}") do
        expect(page).to have_button("Disable")
      end
      within("#merchant-#{@merchant2.id}") do
        expect(page).to have_button("Disable")
      end
      within("#merchant-#{@merchant3.id}") do
        expect(page).to have_no_button("Disable")
      end
    end

    it "I can click 'disable' button and disable the merchant" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
      visit "/admin/merchants"

      within("#merchant-#{@merchant1.id}") do
        click_button "Disable"
      end

      within("#merchant-#{@merchant1.id}") do
        expect(page).to have_no_button("Disable")
      end
    end
  end
end
