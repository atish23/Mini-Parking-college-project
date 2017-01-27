# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'rqrcode_png'
require 'dragonfly'

6.times do |n|
Admin.create!(email: "admin#{n}@example.com", password:"password",parking_id: n)
end
str="1,Example User,MP 09 AB 1234"#{user.name}"+","+"#{user.car_number}"
qr = RQRCode::QRCode.new( str, :size => 8, :level => :h )
png = qr.to_img                                             # returns an instance of ChunkyPNG
png.resize(300,300)

user=User.create!(name:  "Example User",
             email: "shrutikamaske2910@gmail.com",
             password:              "foobar",
             password_confirmation: "foobar",
             mobile: 9910991022,
             car_number:"MP 09 AB 1234",
             activated: true,
             activated_at: Time.zone.now,
             )

user.update_attribute :qrcode, png.to_string

#6.times do |n|
#  name="admin#{n}"
#  email="admin#{n}@admin.com"
#  password="admin123"
#  mobile=9910714777
#  AdminUser.create!(name:name,email:email,password:password,password_confirmation:password,mobile:mobile,parking_id:n)
#end
#

9.times do |n|
  name  = Faker::Name.name
  email = Faker::Internet.email(name)
  number= (9910101000+n)
  password = "password"
  car_number="MP 09 AB 123#{n}"
  str="#{user.id}"+","+"#{user.name}"+","+"#{user.car_number}"
  qr = RQRCode::QRCode.new( str, :size => 6, :level => :h )
  png = qr.to_img                                             # returns an instance of ChunkyPNG
    png=png.resize(300, 300)
  user=User.create!(name:  name,
               email: email,
               mobile: number,
               car_number:car_number,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now,
               )

               user.update_attribute :qrcode, png.to_string
end
50.times do |n|
  name  = Faker::Name.name
  email = Faker::Internet.email(name)
  number= (9910101000+n)
  password = "password"
  car_number="MP 09 AB 12#{n}"
  str="#{user.id}"+","+"#{user.name}"+","+"#{user.car_number}"
  qr = RQRCode::QRCode.new( str, :size => 8, :level => :h )
  png = qr.to_img
  png.resize(300,300)
  user=User.create!(name:  name,
               email: email,
               mobile: number,
               car_number:car_number,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)

               user.update_attribute :qrcode, png.to_string
  end

# names=["Karol Bagh","Nehru Place", "Connaught Place", "Lajpat Nagar", "Sarojni Nagar", "Select City Walk"]
# lats=[28.6629,28.5472,28.6328,28.5789,28.5769,28.5290]
# lngs=[77.2100,77.2508,77.2197,77.2439,77.1961,77.2191]
# 6.times do |n|
#   name =names[n]
#   lat =lats[n]
#   lng =lngs[n]
#   #total_capacity=Faker::Number.between(10,20)
#   total_capacity=12
#   cost=10
#   p=Parking.create!(name:name,lat:lat,lng:lng,total_capacity:total_capacity,filled:0,cost:cost)
#   total_capacity.times do |i|
#   p.parking_lots.create!(availaible:true,slot_id:i+1)
#   end
# end

names=["Empress Mall","Nandanvan","KDK College","Dharampeth","Inox Poonam Mall","Railway Station"]
lats=[21.148194,21.141167,21.1396,21.139,21.1473,21.1496]
lngs=[79.093283,79.126232,  79.1297,79.0631,79.1356,79.0877]
6.times do |n|
  name =names[n]
  lat =lats[n]
  lng =lngs[n]
  #total_capacity=Faker::Number.between(10,20)
  total_capacity=12
  cost=10
  p=Parking.create!(name:name,lat:lat,lng:lng,total_capacity:total_capacity,filled:0,cost:cost)
  total_capacity.times do |i|
  p.parking_lots.create!(availaible:true,slot_id:i+1)
  end
end

require 'active_support/core_ext'

users = User.order(:created_at).take(6)
10.times do
  datetime=Faker::Time.between(2.days.ago, Time.now, :all)
  date= datetime
  in_time = datetime
  out = in_time + 2.hours
  payment = Faker::Number.number(2)
  parking_id=Faker::Number.between(1, 6) #=> 7
  parking_lot_id = Faker::Number.between(1, 10) #=> 7
  payment_type =false

  users.each { |user| user.transactions.create!(in:in_time,out:out,payment:payment,date:date,payment_type:payment_type,parking_id:parking_id,parking_lot_id:parking_lot_id,current_transaction:false,currently_in:false) }
end
