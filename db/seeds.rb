
User.destroy_all
Favorite.destroy_all
Comment.destroy_all

10.times do
  User.create(name: Faker::TvShows::Seinfeld.character, vehicle: Faker::Vehicle.make_and_model)
end

500.times do
  Favorite.create(user_id: rand(1..10), trail_id: rand(1..38))
end

500.times do
  Comment.create(user_id: rand(1..10), trail_id: rand(1..38), content: Faker::TvShows::MichaelScott.quote)
end
