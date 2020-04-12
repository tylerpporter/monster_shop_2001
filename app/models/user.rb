class User < ApplicationRecord
  validates :name, :address, :city, :state, :zip, presence:true
  validates :email, presence:true, uniqueness:true

  enum role: { regular: 0, merchant: 1, admin: 2 }

  has_one :merchant_employee
  has_one :merchant, through: :merchant_employee
  has_secure_password
end
