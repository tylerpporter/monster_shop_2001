require 'rails_helper'

RSpec.describe "As a regisered user" do
  describe "when I visit /profile" do
    before(:each) do
      visit "/register"
      within(".form") do
        fill_in "user[name]", with: "Ryan Camp"
        fill_in "user[address]", with: "1163 S Dudley St"
        fill_in "user[city]", with: "Lakewood"
        fill_in "user[state]", with: "CO"
        fill_in "user[zip]", with: "80232"
        fill_in "user[email]", with: "campryan@comcast.net"
        fill_in "user[password]", with: "password"
        fill_in "user[password_confirmation]", with: "password"
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

    it "If I input an invalid email,
    I get an error message saying the email is already in use" do
      user_2 = User.create(
        name:   "Ethan Hocking",
        address:   "1850 Bassett St",
        city:   "Denver",
        state:   "CO",
        zip:  "80202",
        email:   "eshocking@gmail.com",
        password: "password",
        password_confirmation: "password"
      )

      user_2.save

      click_link "Edit Profile"


      within ".form" do
        fill_in :email, with: "eshocking@gmail.com"
        click_button "Submit"
      end

      expect(page).to have_content("Email has already been taken")
    end
  end
end
