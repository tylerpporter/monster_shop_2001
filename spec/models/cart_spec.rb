require "rails_helper"

RSpec.describe Cart, type: :model do
  describe "This is a PORO" do
    describe "instance methods" do
      before(:each) do
        @cart = Cart.new({})
        @merchant = Merchant.create!(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
        @item1 = @merchant.items.create(name: "bike_item1", description: "Description of Bike Item 1", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588",active?: true, inventory: 3)
        @item2 = @merchant.items.create(name: "bike_item2", description: "Description of Bike Item 1", price: 30, image: "https://www.bikesonline.com/assets/full/S00147.jpg?1554705703",active?: true, inventory: 50)
        @item3 = @merchant.items.create(name: "bike_item3", description: "Description of Bike Item 1", price: 20, image: "https://www.bikesonline.com/assets/full/S00144.jpg?1554705716",active?: true, inventory: 40)
        @item1_id = @item1.id.to_s
        @item2_id = @item2.id.to_s
        @item3_id = @item3.id.to_s
      end
      it '#add_item' do
        expect(@cart.contents).to eql({})

        @cart.add_item(@item1_id)

        expect(@cart.contents).to eql({ @item1_id => 1 })

        @cart.add_item(@item2_id)

        expect(@cart.contents).to eql({ @item1_id => 1, @item2_id => 1 })

        @cart.add_item(@item2_id)

        expect(@cart.contents).to eql({ @item1_id => 1, @item2_id => 2 })
      end

      it '#total_items' do
        expect(@cart.total_items).to eql(0)

        @cart.add_item(@item1_id)
        @cart.add_item(@item1_id)
        @cart.add_item(@item1_id)

        expect(@cart.total_items).to eql(3)
      end

      it '#items' do
        expect(@cart.items).to eql({})

        @cart.add_item(@item1_id)
        @cart.add_item(@item2_id)

        expect(@cart.items).to eql({ @item1 => 1, @item2 => 1 })
      end

      it '#subtotal' do
        expect(@cart.subtotal(@item1)).to eql(0)

        @cart.add_item(@item1_id)
        @cart.add_item(@item2_id)
        @cart.add_item(@item1_id)

        expect(@cart.subtotal(@item1)).to eql(200)
      end

      it '#total' do
        expect(@cart.total).to eql(0)

        @cart.add_item(@item1_id)
        @cart.add_item(@item2_id)
        @cart.add_item(@item1_id)
        @cart.add_item(@item3_id)

        expect(@cart.total).to eql(250)
      end

      it '#max_quantity?' do
        expect(@cart.max_quantity?(@item1_id)).to eql(false)

        @cart.add_item(@item1_id)
        @cart.add_item(@item1_id)
        @cart.add_item(@item1_id)

        expect(@cart.max_quantity?(@item1_id)).to eql(true)
      end

      it '#decrement' do
        @cart.add_item(@item1_id)
        @cart.add_item(@item1_id)
        @cart.add_item(@item1_id)
        @cart.add_item(@item2_id)

        expect(@cart.contents).to eql({ @item1_id => 3, @item2_id => 1 })

        @cart.decrement(@item1_id)

        expect(@cart.contents).to eql({ @item1_id => 2, @item2_id => 1 })

        @cart.decrement(@item1_id)

        expect(@cart.contents).to eql({ @item1_id => 1, @item2_id => 1 })
      end

      it '#remove' do
        @cart.add_item(@item1_id)
        @cart.add_item(@item1_id)
        @cart.add_item(@item1_id)
        @cart.add_item(@item2_id)

        expect(@cart.contents).to eql({ @item1_id => 3, @item2_id => 1 })

        @cart.remove(@item1_id)

        expect(@cart.contents).to eql({ @item2_id => 1 })
      end

      it '#quantity_zero?' do
        @cart.add_item(@item1_id)
        @cart.add_item(@item2_id)

        expect(@cart.quantity_zero?(@item2_id)).to eql(false)

        @cart.decrement(@item2_id)

        expect(@cart.quantity_zero?(@item2_id)).to eql(true)
      end
    end
  end
end
