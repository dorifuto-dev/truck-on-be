
User.destroy_all
Favorite.destroy_all
Comment.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!(:users)

10.times do
  User.create(name: Faker::TvShows::Seinfeld.character, vehicle: Faker::Vehicle.make_and_model)
end

500.times do
  user = rand(1..10)
  trail = rand(1..38)
  if Favorite.where('user_id = ? and trail_id = ?', user, trail).empty?
    Favorite.create(user_id: user, trail_id: trail)
  end
end

500.times do
  Comment.create(user_id: rand(1..10), trail_id: rand(1..38), content: Faker::Lorem.sentences)
end
