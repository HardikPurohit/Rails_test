class Cleaner < ActiveRecord::Base
  has_and_belongs_to_many :cities, dependent: :destroy
  has_many :customers, through: :bookings
  validates_format_of :first_name, :last_name, with:  /[a-zA-Z]+$/, message:  "is invalid", multiline: true
  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: true
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, message:  "is invalid"
end
