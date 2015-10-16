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

names=["Karol Bagh","Nehru Place", "Connaught Place", "Lajpat Nagar", "Sarojni Nagar", "Select City Walk"]
lats=[28.6629,28.5472,28.6328,28.5789,28.5769,28.5290]
lngs=[77.2100,77.2508,77.2197,77.2439,77.1961,77.2191]
6.times do |n|
  name =names[n]
  lat =lats[n]
  lng =lngs[n]
  total_capacity=Faker::Number.between(10,20)
  p=Parking.create!(name:name,lat:lat,lng:lng,total_capacity:total_capacity,filled:0)
  total_capacity.times do |i|
  p.parking_lots.create!(availaible:true,slot_id:i)
  end
end

require 'active_support/core_ext'

users = User.order(:created_at).take(6)
50.times do
  datetime=Faker::Time.between(2.days.ago, Time.now, :all)
  date= datetime.to_date
  in_time = datetime.to_time
  out = in_time + 2.hours
  payment = Faker::Number.number(2)
  parking_id = Faker::Number.between(1, 6) #=> 7
  payment_type =false

  users.each { |user| user.transactions.create!(in:in_time,out:out,payment:payment,date:date,payment_type:payment_type,parking_id:parking_id) }
end
