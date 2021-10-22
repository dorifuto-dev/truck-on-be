FactoryBot.define do
   factory :trail do
     name { Faker::Mountain.name }
     latitude { Faker::Address.latitude }
     longitude { Faker::Address.longitude }
     elevation_gain { Faker::Address.building_number }
     description { Faker::TvShows::SouthPark.quote }
     difficulty { rand(3) }
     route_type { rand(3) }
     traffic { rand(3) }
     nearest_city { Faker::Address.city }
     distance { rand(1..30) }
   end
end
