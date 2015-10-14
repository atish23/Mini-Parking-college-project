# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name:  "Example User",
             email: "example@aditya.com",
             password:              "foobar",
             password_confirmation: "foobar",
             mobile: 9910991022,
             car_number:"MP 09 AB 1234",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

9.times do |n|
  name  = Faker::Name.name
  email = Faker::Internet.email(name)
  number= (9910101000+n)
  password = "password"
  car_number="MP 09 AB 123#{n}"
  User.create!(name:  name,
               email: email,
               mobile: number,
               car_number:car_number,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
90.times do |n|
  name  = Faker::Name.name
  email = Faker::Internet.email(name)
  number= (9910101000+n)
  password = "password"
  car_number="MP 09 AB 12#{n}"
  User.create!(name:  name,
               email: email,
               mobile: number,
               car_number:car_number,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end
