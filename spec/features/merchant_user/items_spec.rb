require 'rails_helper'

RSpec.describe "As a merchant employee" do
  describe "When I visit my items page" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      @pull_toy = @meg.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @meg.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21)
      @merchant_user = User.create(name: "Bob",
                                   address: "123 Glorious Way",
                                   city: "Stuck",
                                   state: "SomeState",
                                   zip: '80122',
                                   email: "bob@example.com",
                                   password: "password",
                                   password_confirmation: "password",
                                   role: 0)
      @meg.hire(@merchant_user)
      visit '/login'
      within(".login_form") do
        fill_in :email, with: "bob@example.com"
        fill_in :password, with: "password"
        click_button("Submit")
      end
      @order1 = @merchant_user.orders.create!(name: 'Meg', address: '123 Stang Ave', city: 'Hershey', state: 'PA', zip: 17033, status: 0)
      @order1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2)
      visit '/merchant/items'
    end
    it "I see all of my items and their info" do

      expect(page).to have_content(@tire.name)
      expect(page).to have_content(@pull_toy.name)
      expect(page).to have_content(@dog_bone.name)

      within "#item-#{@tire.id}" do
        expect(page).to have_content(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content(@tire.price)
        expect(page).to have_css("img[src*='#{@tire.image}']")
        expect(page).to have_content("Active")
        expect(page).to have_content(@tire.inventory)
        expect(page).to have_link("Deactivate")
      end
    end
    it "I can deactivate an active item" do
      within "#item-#{@tire.id}" do
        click_link "Deactivate"
      end

      expect(current_path).to eq('/merchant/items')
      expect(page).to have_content("#{@tire.name} is no longer for sale")
      within "#item-#{@tire.id}" do
        expect(page).to have_content("Inactive")
        expect(page).to_not have_link("Deactivate")
        expect(page).to have_link("Activate")
      end
    end
    it "I can activate an inactive item" do
      within "#item-#{@tire.id}" do
        click_link "Deactivate"
      end

      within "#item-#{@tire.id}" do
        click_link "Activate"
      end

      expect(current_path).to eq('/merchant/items')
      expect(page).to have_content("#{@tire.name} is now available for sale")
      within "#item-#{@tire.id}" do
        expect(page).to have_content("Active")
        expect(page).to_not have_link("Activate")
        expect(page).to have_link("Deactivate")
      end
    end
    it "I can delete an item that has not been ordered" do

      within "#item-#{@tire.id}" do
        expect(page).to_not have_link("Delete")
      end

      within "#item-#{@pull_toy.id}" do
        click_link "Delete"
      end

      expect(current_path).to eq('/merchant/items')
      expect(page).to have_content("#{@pull_toy.name} has been deleted")
      expect(page).to_not have_content(@pull_toy.description)
    end
  end
end
