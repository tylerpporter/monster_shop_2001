require 'rails_helper'

RSpec.describe 'As a visitor' do
  describe 'When I visit the login path' do
    it 'I see a field to enter my email address & password' do

      visit '/login'

      expect(page).to have_css(".login_form")

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

      context 'If I am a merchant user' do
        it 'I am redirected to my merchant dashboard page & I see a flash message that I am logged in' do
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
          expect(page).to have_content("You are logged in")
        end
      end

      context 'If I am a admin user' do
        it 'I am redirected to my admin dashboard page & nd I see a flash message that I am logged in' do
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

          expect(current_path).to eql("/admin")
          expect(page).to have_content("You are logged in")
        end
      end
    end

    describe 'When I submit invalid information' do
      it 'Then I am redirected to the login page
          And I see a flash message that tells me that my credentials were incorrect
          I am NOT told whether it was my email or password that was incorrect' do

        visit '/login'

        within(".login_form") do
          fill_in :email, with: "wrongemail@example.com"
          fill_in :password, with: "wrongpassword"
          click_button("Submit")
        end

        expect(current_path).to eq("/login")
        expect(page).to have_content("Email and/or Password is incorrect")
      end
    end
  end
end

# [ ] done
#
# User Story 14, User cannot log in with bad credentials
#
# As a visitor
# When I visit the login page ("/login")
# And I submit invalid information
# Then I am redirected to the login page
# And I see a flash message that tells me that my credentials were incorrect
# I am NOT told whether it was my email or password that was incorrect
