class User < ApplicationRecord
  validates :name, presence:true
  validates :address, presence:true
  validates :city, presence:true
  validates :state, presence:true
  validates :zip, presence:true
  validates :email, presence:true, uniqueness:true
  validates :password, presence:true
  validates :password_confirmation, presence:true

  enum role: %w(basic admin)

  has_secure_password
end
