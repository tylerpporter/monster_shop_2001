require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I visit the login path' do
    it 'I see a field to enter my email address & password' do
      visit '/login'

      expect(page).to have_css("#login_form")

      within(".login_form") do
        expect(page).to have_css("#email")
        expect(page).to have_css("#password")
      end
    end

    describe 'When I submit valid information' do
      context 'if I am a regular user' do
        it 'I am redirected to my profile page & I see a flash message that I am logged in' do
          user = User.create(name: "basic_test_user",
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
          expect(page).to have_content("You are logged in")
        end
      end
    end
  end
end


        # it 'If I am a merchant user, I am redirected to my merchant dashboard page & I see a flash message that I am logged in' do
        # end

        # it 'If I am an admin user, I am redirected to my admin dashboard page & nd I see a flash message that I am logged in' do
        # end
