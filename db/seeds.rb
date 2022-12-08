# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts 'Destroying all potato prices'
PotatoPrice.destroy_all

puts 'Creating potato prices'

# Creating prices for only 1 hour for now to not overload the DB and slowdown Seeds too much
today_year  = Date.today.year
today_month = Date.today.month
today_day   = Date.today.day
(DateTime.new(today_year, today_month, today_day, 0, 0, 0).to_i..DateTime.new(today_year, today_month, today_day, 0, 59, 59).to_i).to_a.each do |time|
  PotatoPrice.create!(
    price: rand(90.0..110.0).ceil(2),
    time: Time.at(time)
  )
end

puts "#{PotatoPrice.count} potato prices created"

puts 'Create user'
User.create!(
  username: 'renodor'
)
