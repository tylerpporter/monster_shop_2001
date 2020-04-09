require 'rails_helper'

RSpec.describe 'As a registered user' do
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

    visit '/login'

    within(".login_form") do
      fill_in :email, with: "campryan@comcast.net"
      fill_in :password, with: "password"
      click_button("Submit")
    end
  end

  describe 'When I visit my profile page I see a link to reset my password' do
    context 'When I click on the link to reset my password' do
      it 'I see a form with new password & new password confirmation fields' do
        visit "/profile"

        click_on "Reset Password"

        expect(page).to have_css(".form")
      end
    end

    context 'When I fill in both fields with same password & submit the form' do
      it 'I am returned to /profile & see password updated flash message' do

        within(".form") do
          fill_in :password, with: "password"
          fill_in :password_confirmation, with: "password"
          click_button("Submit")
        end

        expect(current_path).to eq("/profile")
        expect(page).to have_content("Your Password Has Been Updated")
      end
    end
  end
end
