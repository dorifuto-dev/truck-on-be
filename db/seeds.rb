# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = User.create(name: 'dev test name', vehicle: 'dev test vehicle')

trail1 = Trail.create(name: 'dev test trail', description: 'dev test description', latitude: 39.1234, longitude: 81.21353, elevation_gain: 500, difficulty: 0, route_type: 0, traffic: 0, distance: 3, nearest_city: 'dev fake city')
