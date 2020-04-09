require 'rails_helper'

RSpec.describe "As a regisered user" do
  describe "when I visit /profile" do
    before(:each) do
      visit "/register"
      within(".form") do
        fill_in :name, with: "Ryan Camp"
        fill_in :address, with: "1163 S Dudley St"
        fill_in :city, with: "Lakewood"
        fill_in :state, with: "CO"
        fill_in :zip, with: "80232"
        fill_in :email, with: "campryan@comcast.net"
        fill_in :password, with: "password"
        fill_in :password_confirmation, with: "password"
        click_button("Submit")
      end
      @user = User.last
    end

    it "I can navigate to an edit page and edit my info" do
      click_link "Edit Profile"

      within ".form" do
        expect(find_field("Name").value).to eq("Ryan Camp")
        expect(find_field("Address").value).to eq("1163 S Dudley St")
        expect(find_field("City").value).to eq("Lakewood")
        expect(find_field("State").value).to eq("CO")
        expect(find_field("Zip").value).to eq("80232")
        expect(find_field("Email").value).to eq("campryan@comcast.net")

        fill_in :name, with: "Ethan Hocking"
        fill_in :address, with: "1850 Bassett St"
        fill_in :city, with: "Denver"
        fill_in :state, with: "CO"
        fill_in :zip, with: "80202"
        fill_in :email, with: "eshocking@gmail.com"

        click_button "Submit"
      end

      expect(page).to have_current_path("/profile")


      expect(page).to have_content("Your profile has been updated")

      expect(page).to have_content("Ethan Hocking")
      expect(page).to have_content("1850 Bassett St")
      expect(page).to have_content("Denver")
      expect(page).to have_content("CO")
      expect(page).to have_content("80202")
      expect(page).to have_content("eshocking@gmail.com")
    end
  end
end

# User Story 20, User Can Edit their Profile Data
#
# As a registered user
# When I visit my profile page
# I see a link to edit my profile data
# When I click on the link to edit my profile data
# I see a form like the registration page
# The form is prepopulated with all my current information except my password
# When I change any or all of that information
# And I submit the form
# Then I am returned to my profile page
# And I see a flash message telling me that my data is updated
# And I see my updated information
