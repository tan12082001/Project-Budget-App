# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
u1 = User.create(name: 'Tan', surname: 'my')

c1 = Category.create(name: 'Foods', icon: 'https://fastly.picsum.photos/id/318/200/200.jpg?hmac=bXfpcSpOySqXMIev1AISKO15vvxPgau4JEA36kuhG1Y', user: u1)
c2 = Category.create(name: 'Households', icon: 'https://fastly.picsum.photos/id/318/200/200.jpg?hmac=bXfpcSpOySqXMIev1AISKO15vvxPgau4JEA36kuhG1Y', user: u1)
c3 = Category.create(name: 'shopping', icon: 'https://fastly.picsum.photos/id/318/200/200.jpg?hmac=bXfpcSpOySqXMIev1AISKO15vvxPgau4JEA36kuhG1Y', user: u1)

e1 = Expenditure.create(name: 'Instant lunch set', amount: 10, author: u1)
e1.categories << c1

e2 = Expenditure.create(name: 'Hair dryer', amount: 100.50, author: u1)
e2.categories << c2

e3 = Expenditure.create(name: 'Rice', amount: 100, author: u1)
e3.categories << c1
e3.categories << c2