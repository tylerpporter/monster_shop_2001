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
  @merchant_user = User.create(name: "regular_test_user",
                               address: "1163 S Dudley St",
                               city: "Lakewood",
                               state: "CO",
                               zip: "80232",
                               email: "dog@example.com",
                               password: "password",
                               password_confirmation: "password",
                               role: 0)
    @meg = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    @meg.hire(@merchant_user)
    @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    @item2 = @meg.items.create(name: "Fish", description: "They'll never pop!", price: 50, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)

    @order1 = @user.orders.create!(name: 'Meg', address: '123 Stang St', city: 'Hershey', state: 'PA', zip: 80218)
    @item_order1 = @order1.item_orders.create!(item: @tire, price: @tire.price, quantity: 2, status: "fulfilled")
    @item_order2 = @order1.item_orders.create!(item: @item2, price: @item2.price, quantity: 3)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@merchant_user)

    visit "/merchant/orders/#{@order1.id}"
  end
  it 'When all items are fulfilled in an order, the order status changes to packaged' do
    expect(@order1.status).to eq("pending")

    within "#item-#{@item_order2.item.id}" do
      click_link "fulfill"
    end

    @order1.reload

    expect(@order1.status).to eq("packaged")
  end
end
