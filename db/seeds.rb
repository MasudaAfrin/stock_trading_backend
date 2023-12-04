# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
user = User.find_or_create_by!(email: 'john@stock.com',
                               name: 'John Doe')
user.update!(password: 'pass123456@')
p "User is created #{user.email}"

user_two = User.find_or_create_by!(email: 'smith@stock.com',
                                   name: 'Sam Smith')
user_two.update!(password: 'pass123456@')
p "User is created #{user_two.email}"
