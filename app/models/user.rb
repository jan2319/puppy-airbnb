class User < ApplicationRecord
  has_many :puppies, dependent: :destroy
  has_many :bookings
  has_many :reviews

  validates_presence_of :phone, :email, :first_name, :last_name, :birthdate

  validates_format_of :phone, :with => /\+?\d{2}\d{3}\d{8,12}$/i , :on => :create, :multiline => true

  validates :email, uniqueness: true
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :on => :create

end


