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
    it { should validate_presence_of :password }
    it { should validate_presence_of :password_confirmation }
  end

  describe User do
      it "can be created as a basic user" do
        user = User.create(name: "basic_test_user",
                           address: "1163 S Dudley St",
                           city: "Lakewood",
                           state: "CO",
                           zip: "80232",
                           email: "campryan@comcast.net",
                           password: "password",
                           password_confirmation: "password",
                           role: 0)

        expect(user.role).to eq("basic")
        expect(user.basic?).to be_truthy
      end
    end
end
