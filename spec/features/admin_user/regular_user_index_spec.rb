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

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin_user)
  end

  it "I can click on 'Users' link in nav bar and be taken to /admin/users index" do
    visit "/admin"

    within(".topnav") do
      click_link "Users"
    end

    expect(current_path).to eql("/admin/users")
  end

end
