require 'rails_helper'

RSpec.describe "Items Index Page" do
  describe "When I visit the items index page" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)

      @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

      @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
    end

    it "all items or merchant names are links" do
      visit '/items'

      expect(page).to have_link(@tire.name)
      expect(page).to have_link(@tire.merchant.name)
      expect(page).to have_link(@pull_toy.name)
      expect(page).to have_link(@pull_toy.merchant.name)
    end

    it "I can see a list of all of the items, unless disabled" do

      visit '/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_link(@meg.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
      end

      within "#item-#{@pull_toy.id}" do
        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_content(@pull_toy.description)
        expect(page).to have_content("Price: $#{@pull_toy.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@pull_toy.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@pull_toy.image}']")
      end

      expect(page).to have_no_css("#item-#{@dog_bone.id}")
    end

    it "I can click on the image for item, which is a link, and be taken to show page." do
      visit "/items"

      within("#item-#{@tire.id}") do
        page.find(".image-link").click
      end

      expect(current_path).to eql("/items/#{@tire.id}")
    end

    it "I can see a section that shows top 5 quanitity purchased and quantity bought of each" do
      dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      dog_item1 = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      dog_item2 = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21)
      dog_item3 = dog_shop.items.create(name: "dog item 3", description: "Description for dog item 3", price: 34, image: "https://images-na.ssl-images-amazon.com/images/I/71V7BlEkwuL._AC_SX425_.jpg", inventory: 43)
      dog_item4 = dog_shop.items.create(name: "dog item 4", description: "Description for dog item 4", price: 45, image: "https://s7d2.scene7.com/is/image/PetSmart/5279001", inventory: 75)
      dog_item5 = dog_shop.items.create(name: "dog item 5", description: "Description for dog item 5", price: 55, image: "https://petco.scene7.com/is/image/PETCO/2763773-center-1", inventory: 100)
      dog_item6 = dog_shop.items.create(name: "dog item 6", description: "Description for dog item 6", price: 55, image: "https://petco.scene7.com/is/image/PETCO/2763773-center-1", inventory: 100)
      dog_item7 = dog_shop.items.create(name: "dog item 7", description: "Description for dog item 7", price: 55, image: "https://petco.scene7.com/is/image/PETCO/2763773-center-1", inventory: 100)
      order1 = Order.create(name: "Ryan", address: "123 S South St", city: "Whatatown", state: "CA", zip: 98765)
      ItemOrder.create(item: dog_item1, order: order1, price: dog_item1.price, quantity: 1200)
      ItemOrder.create(item: dog_item2, order: order1, price: dog_item2.price, quantity: 1100)
      ItemOrder.create(item: dog_item3, order: order1, price: dog_item3.price, quantity: 1500)
      ItemOrder.create(item: dog_item4, order: order1, price: dog_item4.price, quantity: 600)
      ItemOrder.create(item: dog_item5, order: order1, price: dog_item5.price, quantity: 300)
      ItemOrder.create(item: dog_item6, order: order1, price: dog_item6.price, quantity: 2000)
      ItemOrder.create(item: dog_item7, order: order1, price: dog_item7.price, quantity: 700)

      visit "/items"

      within(".most-popular-items") do
        expect(page).to have_content("Most Popular Items:")
        expect(page.all(".item")[0]).to have_content("#{dog_item6.name} - 2000 ordered")
        expect(page.all(".item")[1]).to have_content("#{dog_item3.name} - 1500 ordered")
        expect(page.all(".item")[2]).to have_content("#{dog_item1.name} - 1200 ordered")
        expect(page.all(".item")[3]).to have_content("#{dog_item2.name} - 1100 ordered")
        expect(page.all(".item")[4]).to have_content("#{dog_item7.name} - 700 ordered")
        expect(page).to have_no_content(dog_item4)
        expect(page).to have_no_content(dog_item5)
      end
    end

    it "I can see a section that shows top 5 quanitity purchased and quantity bought of each" do
      dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      dog_item1 = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      dog_item2 = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21)
      dog_item3 = dog_shop.items.create(name: "dog item 3", description: "Description for dog item 3", price: 34, image: "https://images-na.ssl-images-amazon.com/images/I/71V7BlEkwuL._AC_SX425_.jpg", inventory: 43)
      dog_item4 = dog_shop.items.create(name: "dog item 4", description: "Description for dog item 4", price: 45, image: "https://s7d2.scene7.com/is/image/PetSmart/5279001", inventory: 75)
      dog_item5 = dog_shop.items.create(name: "dog item 5", description: "Description for dog item 5", price: 55, image: "https://petco.scene7.com/is/image/PETCO/2763773-center-1", inventory: 100)
      dog_item6 = dog_shop.items.create(name: "dog item 6", description: "Description for dog item 6", price: 55, image: "https://petco.scene7.com/is/image/PETCO/2763773-center-1", inventory: 100)
      dog_item7 = dog_shop.items.create(name: "dog item 7", description: "Description for dog item 7", price: 55, image: "https://petco.scene7.com/is/image/PETCO/2763773-center-1", inventory: 100)
      order1 = Order.create(name: "Ryan", address: "123 S South St", city: "Whatatown", state: "CA", zip: 98765)
      ItemOrder.create(item: dog_item1, order: order1, price: dog_item1.price, quantity: 1200)
      ItemOrder.create(item: dog_item2, order: order1, price: dog_item2.price, quantity: 1100)
      ItemOrder.create(item: dog_item3, order: order1, price: dog_item3.price, quantity: 1500)
      ItemOrder.create(item: dog_item4, order: order1, price: dog_item4.price, quantity: 600)
      ItemOrder.create(item: dog_item5, order: order1, price: dog_item5.price, quantity: 300)
      ItemOrder.create(item: dog_item6, order: order1, price: dog_item6.price, quantity: 2000)
      ItemOrder.create(item: dog_item7, order: order1, price: dog_item7.price, quantity: 700)

      visit "/items"

      within(".least-popular-items") do
        expect(page).to have_content("Least Popular Items:")
        expect(page.all("item")[0]).to have_content("#{dog_item5.name} - 300 ordered")
        expect(page.all("item")[1]).to have_content("#{dog_item4.name} - 600 ordered")
        expect(page.all("item")[2]).to have_content("#{dog_item7.name} - 700 ordered")
        expect(page.all("item")[3]).to have_content("#{dog_item2.name} - 1100 ordered")
        expect(page.all("item")[4]).to have_content("#{dog_item1.name} - 1200 ordered")
        expect(page).to have_no_content(dog_item3)
        expect(page).to have_no_content(dog_item6)
      end
    end
  end
end
