require "rails_helper"

RSpec.describe "As an admin level user" do
  before(:each) do
    @admin_user = User.create!(name: "Bob",
                               address: "123 Glorious Way",
                               city: "Stupendous",
                               state: "SomeState",
                               zip: '80122',
                               email: "bob@example.com",
                               password: "password",
                               password_confirmation: "password",
                               role: 2)
    @regular_user1 = User.create!(name: "Bob_regular1",
                               address: "123 Glorious Way",
                               city: "Stupendous",
                               state: "SomeState",
                               zip: '80122',
                               email: "bob_regular1@example.com",
                               password: "password",
                               password_confirmation: "password",
                               role: 0)
    @regular_user2 = User.create!(name: "bob_regular2",
                               address: "123 Glorious Way",
                               city: "Stupendous",
                               state: "SomeState",
                               zip: '80122',
                               email: "bob_regular2@example.com",
                               password: "password",
                               password_confirmation: "password",
                               role: 0)
    @merchant_user2 = User.create!(name: "Bob_merchant1",
                               address: "123 Glorious Way",
                               city: "Stupendous",
                               state: "SomeState",
                               zip: '80122',
                               email: "bob_merhant1@example.com",
                               password: "password",
                               password_confirmation: "password",
                               role: 1)
    @merchant_user2 = User.create!(name: "Bob_merchant2",
                               address: "123 Glorious Way",
                               city: "Stupendous",
                               state: "SomeState",
                               zip: '80122',
                               email: "bob_merchant2@example.com",
                               password: "password",
                               password_confirmation: "password",
                               role: 1)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
    visit "/admin/users"
  end

  it "I can click on 'Users' link in nav bar and be taken to /admin/users index" do
    visit "/admin"

    within(".topnav") do
      click_link "Users"
    end

    expect(current_path).to eql("/admin/users")
  end

  describe "When I visit the admin/users index page" do
    it "I see the name, date registered and what type of user they are, for all users" do
      within("#user-#{@regular_user1.id}") do
        expect(page).to have_link(@regular_user1.name)
        expect(page).to have_content("Registered: #{@regular_user1.created_at}")
        expect(page).to have_content("Authorization Level: #{@regular_user1.role}")
      end
      within("#user-#{@regular_user2.id}") do
        expect(page).to have_link(@regular_user2.name)
        expect(page).to have_content("Registered: #{@regular_user2.created_at}")
        expect(page).to have_content("Authorization Level: #{@regular_user2.role}")
      end
      within("#user-#{@merchant_user1.id}") do
        expect(page).to have_link(@merchant_user1.name)
        expect(page).to have_content("Registered: #{@merchant_user1.created_at}")
        expect(page).to have_content("Authorization Level: #{@merchant_user1.role}")
      end
      within("#user-#{@merchant_user2.id}") do
        expect(page).to have_link(@merchant_user2.name)
        expect(page).to have_content("Registered: #{@merchant_user2.created_at}")
        expect(page).to have_content("Authorization Level: #{@merchant_user2.role}")
      end
    end

  end

end
