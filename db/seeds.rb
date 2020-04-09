# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Merchant.destroy_all
Item.destroy_all

#merchants
bike_shop = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
dog_shop = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
art_shop = Merchant.create(name: "Ryan's Art Shop", address: '125 Art Ave.', city: 'Littleton', state: 'CO', zip: 80232)
#bike_shop items
bike_item1 = bike_shop.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
bike_item2 = bike_shop.items.create(name: "Entity MH15 Mountain Bike Helmet", description: "The Entity MH15 MTB Helmet builds on current trends to deliver a helmet that is low profile and yet also provides additional protection to the base of the head. Available in matt base colors - the helmets feature some of the best helmet technology in the market today. ", price: 30, image: "https://www.bikesonline.com/assets/full/S00147.jpg?1554705703", inventory: 50)
bike_item3 = bike_shop.items.create(name: "Entity CH15 Road/Mountain Bike Helmet", description: "The Entity CH15 Recreational Helmet is the stylish entry point into bicycle helmets. With solid gloss base colors treated with fine details, the helmets will sit as comfortably on your head as they do in the pack. ", price: 20, image: "https://www.bikesonline.com/assets/full/S00144.jpg?1554705716", inventory: 40)
bike_item4 = bike_shop.items.create(name: "Entity MG15 Long Finger Gel Pad Cycling Gloves", description: "Amazing gloves.", price: 13, image: "https://www.bikesonline.com/assets/full/S00150.jpg?1554705597", inventory: 200)
bike_item5 = bike_shop.items.create(name: "DHaRCO Mens Gloves", description: "Minimalist gloves for ultimate comfort. With a ventilated upper hand and velcro-less easy entry and soft durable synthetic leather palm they are the gloves you don't feel like you're wearing.", price: 23, image: "https://www.bikesonline.com/assets/full/S00258.jpg?1557515068", inventory: 25)
#dog_shop items
dog_item1 = dog_shop.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
dog_item2 = dog_shop.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", inventory: 21)
dog_item3 = dog_shop.items.create(name: "dog item 3", description: "Description for dog item 3", price: 34, image: "https://images-na.ssl-images-amazon.com/images/I/71V7BlEkwuL._AC_SX425_.jpg", inventory: 43)
dog_item4 = dog_shop.items.create(name: "dog item 4", description: "Description for dog item 4", price: 45, image: "https://s7d2.scene7.com/is/image/PetSmart/5279001", inventory: 75)
dog_item5 = dog_shop.items.create(name: "dog item 5", description: "Description for dog item 5", price: 55, image: "https://petco.scene7.com/is/image/PETCO/2763773-center-1", inventory: 100)
#art_shop items
art_item1 = art_shop.items.create(name: "Art Item 1", description: "Description for Art Item 1", price: 5, image: "https://artfulparent-wpengine.netdna-ssl.com/wp-content/uploads/2014/01/81tP1TmUQL._SL1500_-300x300.jpg", active?: true, inventory: 100)
art_item2 = art_shop.items.create(name: "Art Item 2", description: "Description for Art Item 2", price: 10, image: "https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcQhiGMjsmR_2_zIpc8FSJPAJvabtRcujG71gyIJdKDSFzf-CoxLVpeo8MyJ84-7_Sl1KqHS4dI7Ba3a5BjH5B5F4rrcEZGm5360mAQN5m8wJHxtoUNz7lvjrg&usqp=CAE", active?: true, inventory: 200)
art_item3 = art_shop.items.create(name: "Art Item 3", description: "Description for Art Item 3", price: 15, image: "https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcS2JTXTuK_kKds5jz983dsv_dwfS2xB8SioYmvPCB77sRzMLg9pnrW7g0ENRS54DRQx13zYSW3FUbPotsDIZoiSK82o2m989ngx3upKpmxUqrZuYQNRNCcJcw&usqp=CAY", active?: true, inventory: 300)
art_item4 = art_shop.items.create(name: "Art Item 4", description: "Description for Art Item 4", price: 20, image: "https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQef2vBVGNHm1xN9Nh9czjORUhU5hqlgyL39rye5mnd_5wAEBXSrlVcz74zaj7Ng4_OMuGC73mp6gBQtGEmcr1CUyc2HxveGJ5pwxVaA86Ju0gdY3MCy6M3&usqp=CAE", active?: true, inventory: 400)
art_item5 = art_shop.items.create(name: "Art Item 5", description: "Description for Art Item 5", price: 25, image: "https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRlgSsb8ePDfkScJrkJPPboHgB99Mg4tgr5_4wWGom9Jn02CUbGnFQ8XLtVvh-3J4ZQ31xyafKJNTZw_QSatLJYF0enOhWIPiz7lESV-hRi5Be3GdIa-0Py&usqp=CAE", active?: true, inventory: 500)

order1 = Order.create(name: "Ryan", address: "123 S South St", city: "Whatatown", state: "CA", zip: 98765)
order2 = Order.create(name: "Richard", address: "456 S North St", city: "Whatitown", state: "NY", zip: 12345)

ItemOrder(item: dog_item1, order: order1, price: dog_item1.price, quantity: 1500)
ItemOrder(item: dog_item2, order: order1, price: dog_item2.price, quantity: 1200)
ItemOrder(item: dog_item3, order: order1, price: dog_item3.price, quantity: 900)
ItemOrder(item: dog_item4, order: order1, price: dog_item4.price, quantity: 600)
ItemOrder(item: dog_item5, order: order1, price: dog_item5.price, quantity: 300)
ItemOrder(item: art_item1, order: order1, price: art_item1.price, quantity: 1400)
ItemOrder(item: art_item2, order: order2, price: art_item2.price, quantity: 1100)
ItemOrder(item: art_item3, order: order2, price: art_item3.price, quantity: 800)
ItemOrder(item: art_item4, order: order2, price: art_item4.price, quantity: 500)
ItemOrder(item: art_item5, order: order2, price: art_item5.price, quantity: 200)
ItemOrder(item: bike_item1, order: order2, price: bike_item1.price, quantity: 1300)
ItemOrder(item: bike_item2, order: order2, price: bike_item2.price, quantity: 1000)
ItemOrder(item: bike_item3, order: order2, price: bike_item3.price, quantity: 700)
ItemOrder(item: bike_item4, order: order2, price: bike_item3.price, quantity: 100)
ItemOrder(item: bike_item5, order: order2, price: bike_item5.price, quantity: 400)
