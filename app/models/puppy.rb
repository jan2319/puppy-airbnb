class Puppy < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  belongs_to :user
  belongs_to :breed

  validates_presence_of :photo_url, :name, :description, :street, :zipcode, :city, :country, :daily_price, :birthdate, :toilet_training_level

  validates :toilet_training_level, inclusion: { in: [1, 2, 3, 4, 5] }
end
