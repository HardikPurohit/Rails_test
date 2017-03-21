class Customer < ActiveRecord::Base
  has_many :bookings
  has_many :cleaners, through: :bookings
  validates :first_name, :last_name, :phone_number, presence: true
  validates :phone_number, numericality: { message: "%{value} seems wrong" }, length: {is:10, message: "Invalid"}
end
