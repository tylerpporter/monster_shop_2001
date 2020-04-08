
require 'rails_helper'

RSpec.describe 'Site Navigation' do
  describe 'As a Visitor' do
    before(:each) do
      visit "/"
    end
    it "I see a nav bar with links to all pages" do
      within 'nav' do
        click_link 'All Items'
      end

      expect(current_path).to eq('/items')

      within 'nav' do
        click_link 'All Merchants'
      end

      expect(current_path).to eq('/merchants')

      within 'nav' do
        click_link("Cart: 0")
      end

      expect(current_path).to eq('/cart')

      within 'nav' do
        click_link("Login")
      end

      expect(current_path).to eq('/login')

      within 'nav' do
        click_link("Register")
      end

      expect(current_path).to eq('/register')

      within('nav') do
        click_link("Home")
      end

      expect(current_path).to eq('/')

      within('nav') do
        expect(page).to have_no_link("Profile")
        expect(page).to have_no_link("Logout")
        expect(page).to have_no_link("Merchant Dashboard")
        expect(page).to have_no_link("Admin Dashboard")
        expect(page).to have_no_link("All Users")
      end
    end
  end
end
