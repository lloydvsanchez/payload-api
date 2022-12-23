# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
john = Guest.create(first_name: 'John', last_name: 'Doe', email: 'johndoe@asdf.com', phone_numbers: ['+123456789'])
jane = Guest.create(first_name: 'Jane', last_name: 'Dope', email: 'janedope@asdf.com', phone_numbers: ['+987654321'])

Reservation.create(code: 'testcode', start_date: 4.days.from_now.to_date, end_date: 8.days.from_now.to_date, nights:4, adults: 2, children: 1, infants: 1, guest: john, payout_price: 140.0, security_price: 10.0)
