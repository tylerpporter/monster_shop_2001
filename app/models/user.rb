class User < ApplicationRecord
  validates :name, :address, :city, :state, :zip, presence:true
  validates :email, presence:true, uniqueness:true
  validates_presence_of :password, required:true
  validates :password_confirmation, presence:true

  has_many :orders 

  enum role: { regular: 0, merchant: 1, admin: 2 }

  has_secure_password
end
