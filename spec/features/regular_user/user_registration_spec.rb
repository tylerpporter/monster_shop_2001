require "rails_helper"

RSpec.describe "When i visit /profile" do
  before(:each) do
    visit "/register"
    within(".form") do
      fill_in :name, with: "Ryan Camp"
      fill_in :address, with: "1163 S Dudley St"
      fill_in :city, with: "Lakewood"
      fill_in :state, with: "CO"
      fill_in :zip, with: "80232"
      fill_in :email, with: "campryan@comcast.net"
      fill_in :password, with: "password"
      fill_in :password_confirmation, with: "password"
      click_button("Submit")
    end
    @user = User.last
  end
  it "I can see my user name displayed" do
    expect(page).to have_content("#{@user.name}")
  end

  it "I can navigate away and come back to same user profile" do
    expect(page).to have_content("#{@user.name}")

    visit "/register"
    visit "/profile"

    expect(page).to have_content("#{@user.name}")
  end
end
