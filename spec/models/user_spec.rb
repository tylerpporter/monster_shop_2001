require "rails_helper"

RSpec.describe User do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip }
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should have_secure_password }
  end

  describe 'relationships' do
    it {should have_many :orders}
  end

  describe "roles" do
    it "create regular user" do
      user = User.create(name: "regular_test_user",
                         address: "1163 S Dudley St",
                         city: "Lakewood",
                         state: "CO",
                         zip: "80232",
                         email: "campryan@comcast.net",
                         password: "password",
                         password_confirmation: "password",
                         role: 0)

      expect(user.role).to eq("regular")
      expect(user.regular?).to be_truthy
    end

    it "create merchant user" do
      user = User.create(name: "merchant_test_user",
                             address: "222 Merchant St",
                             city: "Lakewood",
                             state: "WA",
                             zip: "80232",
                             email: "ryan@comcast.net",
                             password: "123password",
                             password_confirmation: "123password",
                             role: 1)

      expect(user.role).to eq("merchant")
      expect(user.merchant?).to be_truthy
    end

    it "create admin user" do
      user = User.create(name: "admin_test_user",
                          address: "1111 Admin St",
                          city: "Lakewood",
                          state: "CA",
                          zip: "80232",
                          email: "camp@example.com",
                          password: "password123",
                          password_confirmation: "password123",
                          role: 2)

      expect(user.role).to eq("admin")
      expect(user.admin?).to be_truthy
    end
  end
end
