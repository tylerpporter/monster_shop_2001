require "rails_helper"

RSpec.describe "As a merchant level user" do
  describe "I have access to certain links in my nav bar." do
    before(:each) do
      @merchant_user = User.create(name: "Bob",
                                   address: "123 Glorious Way",
                                   city: "Stupendous",
                                   state: "SomeState",
                                   zip: '80122',
                                   email: "bob@example.com",
                                   password: "password",
                                   password_confirmation: "password",
                                   role: 1)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)
      visit "/merchant"
    end

    it "I can click link to return to welcome." do
      within(".topnav") do
        click_link "Home"
        expect(current_path).to eql("/")
      end
    end

    it "I can click link to browse all items" do
      within(".topnav") do
        click_link "All Items"
        expect(current_path).to eql("/items")
      end
    end

    it "I can click link to browse all merchants" do
      within(".topnav") do
        click_link "All Merchants"
        expect(current_path).to eql("/merchants")
      end
    end

    it "I can click link to see shopping cart" do
      within(".topnav") do
        click_link "Cart: 0"
        expect(current_path).to eql("/cart")
      end
    end

    it "I can click link to see shopping cart" do
      within(".topnav") do
        click_link "My Profile"
        expect(current_path).to eql("/profile")
      end
    end

    it "I can click link to see shopping cart" do
      within(".topnav") do
        click_link "Logout"
        expect(current_path).to eql("/logout")
      end
    end

    it "I can click link to see shopping cart" do
      within(".topnav") do
        click_link "Logout"
        expect(current_path).to eql("/merchant")
      end
    end
  end
end
