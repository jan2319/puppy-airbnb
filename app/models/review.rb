class Review < ApplicationRecord
  belongs_to :user
  belongs_to :puppy
  belongs_to :booking

  validates_presence_of :title, :description, :rating

  validates :rating, inclusion: { in: [1, 2, 3, 4, 5] }
end

