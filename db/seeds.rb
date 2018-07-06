# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


require 'json'
require 'open-uri'
require 'nokogiri'
require_relative "url.rb"
require_relative "addresses.rb"

## Clean old database ##

puts 'Cleaning database...'
Review.destroy_all
Booking.destroy_all
Puppy.destroy_all
Breed.destroy_all
User.destroy_all


## Create breeds table ##

puts 'Creating breeds...'

breed_list = JSON.parse(open("https://dog.ceo/api/breeds/list/all").read)

breed_array = breed_list["message"].to_a

breed_array.each do |breed|
  Breed.create(name: breed[0].capitalize)
end

## Create a user to create all the puppies ##

puts 'Creating users...'

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

## Create a test user to check as a "new user" ##

user_attributes = [
  { email: "test@gmail.com",
    password: "password",
    password_confirmation: "password",
    phone: "+4915123008123",
    first_name: "Cyrus",
    last_name: "Acla",
    birthdate: Date.today - 50,
  }
]

User.create!(user_attributes)


puts 'Creating puppies...'

num = $addresses.size

num.times do |i|

  puppies_attributes = {
    title: Faker::Lorem.sentence(9),
    name: Faker::Name.first_name,
    description: Faker::Lorem.paragraph(8),
    street: $addresses[i]["street"].capitalize,
    zipcode: $addresses[i]["postcode"],
    city: $addresses[i]["city"].capitalize,
    country: '',
    latitude: $addresses[i]["coordinates"]["latitude"].to_f,
    longitude: $addresses[i]["coordinates"]["longitude"].to_f,
    daily_price: (rand(20..80).to_i)*100,
    birthdate: Date.today - (rand(5..20)),
    toilet_training_level: rand(1..5),
    user_id: User.all.pluck(:id).sample,
    breed_id: Breed.all.pluck(:id).sample,
    photo_url: $res[i],
  }

  Puppy.create!(puppies_attributes)

end

puppies_attributes2 = [
  {
    title: 'Fluffy Puppy that is super cute',
    name: 'Cyrus',
    description: Faker::Lorem.paragraph(8),
    street: 'Via Stendhal 41',
    zipcode: '20144',
    city: 'Milano',
    country: 'Italy',
    daily_price: 5900,
    birthdate: Date.today - (rand(5..20)),
    toilet_training_level: 4,
    user_id: User.all.pluck(:id).sample,
    breed_id: Breed.all.pluck(:id).sample,
    photo_url: 'https://cdn3.list25.com/wp-content/uploads/2013/08/whiteschnauzerpuppy-610x626.jpg',
  },
  {
    title: 'British cute puppy everyone loves',
    name: 'Ben',
    description: Faker::Lorem.paragraph(8),
    street: '15 Tamarisk Avenue',
    zipcode: 'RG2 8JB',
    city: 'Reading',
    country: 'United Kingdom',
    daily_price: 4900,
    birthdate: Date.today - (rand(5..20)),
    toilet_training_level: 3,
    user_id: User.all.pluck(:id).sample,
    breed_id: Breed.all.pluck(:id).sample,
    photo_url: 'https://cdn4.list25.com/wp-content/uploads/2013/08/Toypuddle-610x412.jpg',
  },
  {
    title: 'Italian Super Puppy',
    name: 'Gigi',
    description: Faker::Lorem.paragraph(8),
    street: 'Corso Magenta 38',
    zipcode: '20123',
    city: 'Milano',
    country: 'Italy',
    daily_price: 7900,
    birthdate: Date.today - (rand(5..20)),
    toilet_training_level: 5,
    user_id: User.all.pluck(:id).sample,
    breed_id: Breed.all.pluck(:id).sample,
    photo_url: 'https://cdn3.list25.com/wp-content/uploads/2013/08/Rottweilerpuppy2-610x412.jpg',
  },
  {
    title: 'German Puppy that will make you smile everyday',
    name: 'Jan',
    description: Faker::Lorem.paragraph(8),
    street: 'Schleissheimer Strasse 65',
    zipcode: '80797',
    city: 'Munich',
    country: 'Germany',
    daily_price: 6900,
    birthdate: Date.today - (rand(5..20)),
    toilet_training_level: 2,
    user_id: User.all.pluck(:id).sample,
    breed_id: Breed.all.pluck(:id).sample,
    photo_url: 'https://cdn2.list25.com/wp-content/uploads/2013/08/SiberianHuskypuppyinbasket2-610x412.jpg',
  },
  {
    title: 'A puppy from Belgium',
    name: 'Stephanie',
    description: Faker::Lorem.paragraph(8),
    street: 'Corso Magenta 28',
    zipcode: '20123',
    city: 'Milano',
    country: 'Italy',
    daily_price: 4900,
    birthdate: Date.today - (rand(5..20)),
    toilet_training_level: 1,
    user_id: User.all.pluck(:id).sample,
    breed_id: Breed.all.pluck(:id).sample,
    photo_url: 'https://cdn4.list25.com/wp-content/uploads/2013/08/BostonTerrier2-610x412.jpg',
  },
]

  Puppy.create!(puppies_attributes2)


puts "Creating Bookings"

30.times do |i|

  bookings_attributes = {
    start_date: Date.today - 10,
    end_date: Date.today - 5,
    total_price: 5*5000,
    user_id: User.all.pluck(:id).sample,
    puppy_id: Puppy.all.pluck(:id).sample,
  }

  booking = Booking.create!(bookings_attributes)

  1.times do |i|

    reviews_attributes =
      {
        title: Faker::Lorem.sentence(4),
        description: Faker::Lorem.paragraph(8),
        rating: rand(1..5),
        booking_id: booking.id,
        user_id: booking.user.id,
        puppy_id: booking.puppy.id,
      }

    Review.create!(reviews_attributes)

  end
end


puts 'Finished!'
