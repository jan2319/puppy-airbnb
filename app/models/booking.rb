class Booking < ApplicationRecord
  belongs_to :puppy
  belongs_to :user
  validates_presence_of :start_date, :end_date, :total_price
end
