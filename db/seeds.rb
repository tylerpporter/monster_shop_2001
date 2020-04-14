# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ItemOrder.destroy_all
MerchantEmployee.destroy_all
Review.destroy_all
Item.destroy_all
Order.destroy_all
Merchant.destroy_all
User.destroy_all
#users
regular_user = User.create!(name:"regular_user", address: "1 Regularuser way", city: "onetown", state: "onestate", zip: "12345", email:"user@example.com", password:"password_regular", role: 0)
bike_shop_employee = User.create!(name:"bike_shop_employee", address: "2 merchantuser way", city: "twotown", state: "twostate", zip: "12345", email:"merchant@example.com", password:"password_merchant", role: 0)
dog_shop_employee = User.create!(name:"dog_shop_employee", address: "3 merchantuser way", city: "threetown", state: "threestate", zip: "12345", email:"merchant2@example.com", password:"password_merchant2", role: 0)
art_shop_employee = User.create!(name:"art_shop_employee", address: "4 merchantuser way", city: "fourtown", state: "fourstate", zip: "12345", email:"merchant3@example.com", password:"password_merchant3", role: 0)
admin_user = User.create!(name:"admin_user", address: "5 adminuser way", city: "fivetown", state: "fivestate", zip: "12345", email:"admin@example.com", password:"password_admin", role: 2)
#merchants
bike_shop = Merchant.create!(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create!(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
art_shop = Merchant.create!(name: "Ryan's Art Shop", address: '125 Art Ave.', city: 'Littleton', state: 'CO', zip: 80232)
#hire_employees
bike_shop.hire(bike_shop_employee)
dog_shop.hire(dog_shop_employee)
art_shop.hire(art_shop_employee)
#bike_shop items
bike_item1 = bike_shop.items.create(name: "bike_item1", description: "Description of Bike Item 1", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",active?: true, inventory: 12)
bike_item2 = bike_shop.items.create(name: "bike_item2", description: "Description of Bike Item 1", price: 30, image: "https://www.bikesonline.com/assets/full/S00147.jpg?1554705703",active?: true, inventory: 50)
bike_item3 = bike_shop.items.create(name: "bike_item3", description: "Description of Bike Item 1", price: 20, image: "https://www.bikesonline.com/assets/full/S00144.jpg?1554705716",active?: true, inventory: 40)
bike_item4 = bike_shop.items.create(name: "bike_item4", description: "Description of Bike Item 1", price: 13, image: "https://www.bikesonline.com/assets/full/S00150.jpg?1554705597",active?: true, inventory: 200)
bike_item5 = bike_shop.items.create(name: "bike_item5", description: "Description of Bike Item 1", price: 23, image: "https://www.bikesonline.com/assets/full/S00258.jpg?1557515068",active?: true, inventory: 25)
#dog_shop items
dog_item1 = dog_shop.items.create(name: "dog_item1", description: "Description of Dog Item 1", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg",active?: true, inventory: 32)
dog_item2 = dog_shop.items.create(name: "dog_item2", description: "Description of Dog Item 2", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg",active?: true, inventory: 21)
dog_item3 = dog_shop.items.create(name: "dog_item3", description: "Description of Dog Item 3", price: 34, image: "https://images-na.ssl-images-amazon.com/images/I/71V7BlEkwuL._AC_SX425_.jpg",active?: true, inventory: 43)
dog_item4 = dog_shop.items.create(name: "dog_item4", description: "Description of Dog Item 4", price: 45, image: "https://s7d2.scene7.com/is/image/PetSmart/5279001",active?: true, inventory: 75)
dog_item5 = dog_shop.items.create(name: "dog_item5", description: "Description of Dog Item 5", price: 55, image: "https://petco.scene7.com/is/image/PETCO/2763773-center-1",active?: true, inventory: 100)
#art_shop items
art_item1 = art_shop.items.create(name: "art_item1", description: "Description for Art Item 1", price: 5, image: "https://artfulparent-wpengine.netdna-ssl.com/wp-content/uploads/2014/01/81tP1TmUQL._SL1500_-300x300.jpg", active?: true, inventory: 100)
art_item2 = art_shop.items.create(name: "art_item2", description: "Description for Art Item 2", price: 10, image: "https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcQhiGMjsmR_2_zIpc8FSJPAJvabtRcujG71gyIJdKDSFzf-CoxLVpeo8MyJ84-7_Sl1KqHS4dI7Ba3a5BjH5B5F4rrcEZGm5360mAQN5m8wJHxtoUNz7lvjrg&usqp=CAE", active?: true, inventory: 200)
art_item3 = art_shop.items.create(name: "art_item3", description: "Description for Art Item 3", price: 15, image: "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcS2JTXTuK_kKds5jz983dsv_dwfS2xB8SioYmvPCB77sRzMLg9pnrW7g0ENRS54DRQx13zYSW3FUbPotsDIZoiSK82o2m989ngx3upKpmxUqrZuYQNRNCcJcw&usqp=CAY", active?: true, inventory: 300)
art_item4 = art_shop.items.create(name: "art_item4", description: "Description for Art Item 4", price: 20, image: "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQef2vBVGNHm1xN9Nh9czjORUhU5hqlgyL39rye5mnd_5wAEBXSrlVcz74zaj7Ng4_OMuGC73mp6gBQtGEmcr1CUyc2HxveGJ5pwxVaA86Ju0gdY3MCy6M3&usqp=CAE", active?: true, inventory: 400)
art_item5 = art_shop.items.create(name: "art_item5", description: "Description for Art Item 5", price: 25, image: "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRlgSsb8ePDfkScJrkJPPboHgB99Mg4tgr5_4wWGom9Jn02CUbGnFQ8XLtVvh-3J4ZQ31xyafKJNTZw_QSatLJYF0enOhWIPiz7lESV-hRi5Be3GdIa-0Py&usqp=CAE", active?: true, inventory: 500)
#reviews
bike_item1.reviews.create!(title:"review1", content: "Body for review 1", rating: 1 )
bike_item1.reviews.create(title:"review2", content: "Body for review 2", rating: 2 )
bike_item1.reviews.create(title:"review3", content: "Body for review 3", rating: 3 )
bike_item2.reviews.create(title:"review4", content: "Body for review 4", rating: 4 )
bike_item2.reviews.create(title:"review5", content: "Body for review 5", rating: 5 )
bike_item3.reviews.create(title:"review6", content: "Body for review 6", rating: 1 )
bike_item4.reviews.create(title:"review7", content: "Body for review 7", rating: 2 )
bike_item5.reviews.create(title:"review8", content: "Body for review 8", rating: 3 )
dog_item1.reviews.create(title:"review9", content: "Body for review 9", rating: 4 )
dog_item1.reviews.create(title:"review10", content: "Body for review 10", rating: 5 )
dog_item1.reviews.create(title:"review11", content: "Body for review 11", rating: 1 )
dog_item2.reviews.create(title:"review12", content: "Body for review 12", rating: 2 )
dog_item2.reviews.create(title:"review13", content: "Body for review 13", rating: 3 )
dog_item3.reviews.create(title:"review14", content: "Body for review 14", rating: 4 )
dog_item4.reviews.create(title:"review15", content: "Body for review 15", rating: 5 )
dog_item5.reviews.create(title:"review16", content: "Body for review 16", rating: 1 )
art_item1.reviews.create(title:"review17", content: "Body for review 17", rating: 2 )
art_item1.reviews.create(title:"review18", content: "Body for review 18", rating: 3 )
art_item1.reviews.create(title:"review19", content: "Body for review 19", rating: 4 )
art_item2.reviews.create(title:"review20", content: "Body for review 20", rating: 5 )
art_item2.reviews.create(title:"review21", content: "Body for review 21", rating: 1 )
art_item3.reviews.create(title:"review22", content: "Body for review 22", rating: 2 )
art_item4.reviews.create(title:"review23", content: "Body for review 23", rating: 3 )
art_item5.reviews.create(title:"review24", content: "Body for review 24", rating: 4 )
#order
order1 = Order.create(name: "Order1", address: "123 S Order2 way", city: "Whatatown", state: "CA", zip: 98765)
order2 = Order.create(name: "order2", address: "456 S Order2 way", city: "Whatitown", state: "NY", zip: 12345)
order3 = Order.create(name: "Order3", address: "456 S Order3 way", city: "Whatitown", state: "NY", zip: 12345)
#item_orders_creation
order1.create_item_orders({bike_item1 => 4, bike_item2 => 10, dog_item1=> 7, art_item1 => 2})
order2.create_item_orders({bike_item3 => 7, dog_item2 => 6, dog_item3=> 9, art_item2 => 1})
order3.create_item_orders({bike_item4 => 4, dog_item4 => 8, art_item3=> 11, art_item4 => 4})
