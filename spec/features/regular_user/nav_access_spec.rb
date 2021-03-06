require "rails_helper"

RSpec.describe "As a regular level user" do
  describe "I have access to certain links in my nav bar." do
    before(:each) do
      @regular_user = User.create(name: "Bob",
                                   address: "123 Glorious Way",
                                   city: "Stupendous",
                                   state: "SomeState",
                                   zip: '80122',
                                   email: "bob@example.com",
                                   password: "password",
                                   password_confirmation: "password",
                                   role: 0)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@regular_user)

      visit "/"
    end

    it "I can click link to browse all items" do

      within(".topnav") do
        click_link "All Items"
      end

      expect(current_path).to eql("/items")
    end

    it "I can click link to browse all merchants" do

      within(".topnav") do
        click_link "All Merchants"
      end

      expect(current_path).to eql("/merchants")
    end

    it "I can click link to see shopping cart" do

      within(".topnav") do
        click_link "Cart: 0"
      end

      expect(current_path).to eql("/cart")
    end

    it "I can click link to navigate to profile page" do

      within(".topnav") do
        click_link "My Profile"
      end

      expect(current_path).to eql("/profile")
    end

    it "I can click link to logout of app" do

      within(".topnav") do
        click_link "Logout"
      end

      expect(current_path).to eql("/")
    end

    it "I can click link to return to welcome." do
      visit "/profile"
      within(".topnav") do
        click_link "Home"
      end

      expect(current_path).to eql("/")
    end

    it "I cannot see certain links" do
      within(".topnav") do
        expect(page).to have_no_link("Login")
        expect(page).to have_no_link("Register")
      end
    end

    it "I can see text that confirms that I am logged in" do
      within(".topnav") do
        expect(page).to have_content("Logged in as #{@regular_user.name}")
      end
    end

    it "I see 404 error when navigating to restricted pages" do
      visit '/merchant'

      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/admin'

      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
