require "rails_helper"

RSpec.describe "As an admin level user" do
  before(:each) do
    @admin_user = User.create!(name: "Bob",
                               address: "123 Glorious Way",
                               city: "Something",
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

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
    visit "/admin/users/#{@regular_user1.id}"
  end
  describe "when I visit a users profile page" do
    it "I see the same info the user would see, minus link to edit profile" do
      within(".user-profile-main-block") do
        expect(page).to have_content(@regular_user1.name)
        expect(page).to have_content(@regular_user1.address)
        expect(page).to have_content(@regular_user1.city)
        expect(page).to have_content(@regular_user1.state)
        expect(page).to have_content(@regular_user1.zip)
        expect(page).to have_content(@regular_user1.email)
        expect(page).to have_no_link("Edit Profile")
      end
      within(".reset-password-main-block") do
        expect(page).to have_no_link("Reset Password")
      end
      expect(page).to have_no_link("My Orders")
    end
  end
end
