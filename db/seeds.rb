# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'json'
require 'open-uri'



puts 'Cleaning database...'
Puppy.destroy_all
Breed.destroy_all

puts 'Creating breeds...'

breed_list = JSON.parse(open("https://dog.ceo/api/breeds/list/all").read)

breed_array = breed_list["message"].to_a

breed_array.each do |breed|
  Breed.create(name: breed)
end

user_attributes = [
  { email: "puppylover@gmail.com",
    password: "password",
    password_confirmation: "password",
    phone: "+4915123008181",
    first_name: "Jan",
    last_name: "Henning",
    birthdate: Date.today,
  }
]

User.create!(user_attributes)

puts 'Creating puppies...'

puppies_attributes = [
  {
    title: 'Fluffy Puppy that is super cute',
    name: 'Cyrus',
    description: Faker::Lorem.paragraph(2),
    street: Faker::Address.street_address,
    zipcode: Faker::Address.zip_code,
    city: 'Munich',
    country: Faker::Address.country,
    daily_price: 5900,
    birthdate: Date.today,
    toilet_training_level: 4,
    user_id: 1,
    breed_id: 1,
    photo_url: 'https://cdn3.list25.com/wp-content/uploads/2013/08/whiteschnauzerpuppy-610x626.jpg',
  },
  {
    title: 'British cute puppy everyone loves',
    name: 'Ben',
    description: Faker::Lorem.paragraph(2),
    street: Faker::Address.street_address,
    zipcode: Faker::Address.zip_code,
    city: Faker::Address.city,
    country: Faker::Address.country,
    daily_price: 4900,
    birthdate: Date.today,
    toilet_training_level: 3,
    user_id: 1,
    breed_id: 2,
    photo_url: 'https://cdn4.list25.com/wp-content/uploads/2013/08/Toypuddle-610x412.jpg',
  },
  {
    title: 'Italian Super Puppy',
    name: 'Gigi',
    description: Faker::Lorem.paragraph(2),
    street: Faker::Address.street_address,
    zipcode: Faker::Address.zip_code,
    city: Faker::Address.city,
    country: Faker::Address.country,
    daily_price: 7900,
    birthdate: Date.today,
    toilet_training_level: 5,
    user_id: 1,
    breed_id: 3,
    photo_url: 'https://cdn3.list25.com/wp-content/uploads/2013/08/Rottweilerpuppy2-610x412.jpg',
  },
  {
    title: 'German Puppy that will make you smile',
    name: 'Jan',
    description: Faker::Lorem.paragraph(2),
    street: Faker::Address.street_address,
    zipcode: Faker::Address.zip_code,
    city: Faker::Address.city,
    country: Faker::Address.country,
    daily_price: 6900,
    birthdate: Date.today,
    toilet_training_level: 2,
    user_id: 1,
    breed_id: 4,
    photo_url: 'https://cdn2.list25.com/wp-content/uploads/2013/08/SiberianHuskypuppyinbasket2-610x412.jpg',
  },
  {
    title: 'A puppy from Belgium',
    name: 'Stephanie',
    description: Faker::Lorem.paragraph(2),
    street: Faker::Address.street_address,
    zipcode: Faker::Address.zip_code,
    city: Faker::Address.city,
    country: Faker::Address.country,
    daily_price: 4900,
    birthdate: Date.today,
    toilet_training_level: 1,
    user_id: 1,
    breed_id: 5,
    photo_url: 'https://cdn4.list25.com/wp-content/uploads/2013/08/BostonTerrier2-610x412.jpg',
  },
]

Puppy.create!(puppies_attributes)


puts 'Finished!'
