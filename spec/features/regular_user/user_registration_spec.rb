require "rails_helper"

RSpec.describe "When i visit /profile" do
  it "I can see my user name displayed" do
    visit "/register"
    within(".form") do
      fill_in "user[name]", with: "Ryan Camp"
      fill_in "user[address]", with: "1163 S Dudley St"
      fill_in "user[city]", with: "Lakewood"
      fill_in "user[state]", with: "CO"
      fill_in "user[zip]", with: "80232"
      fill_in "user[email]", with: "campryan@comcast.net"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
      click_button("Submit")
    end
    user = User.last
    expect(page).to have_content("#{user.name}")
  end

  it "I can navigate away and come back to same user profile" do
    visit "/register"
    within(".form") do
      fill_in "user[name]", with: "Ryan Camp"
      fill_in "user[address]", with: "1163 S Dudley St"
      fill_in "user[city]", with: "Lakewood"
      fill_in "user[state]", with: "CO"
      fill_in "user[zip]", with: "80232"
      fill_in "user[email]", with: "campryan@comcast.net"
      fill_in "user[password]", with: "password"
      fill_in "user[password_confirmation]", with: "password"
      click_button("Submit")
    end
    user = User.last
    expect(page).to have_content("#{user.name}")

    visit "/register"
    visit "/profile"

    expect(page).to have_content("#{user.name}")
  end

end
