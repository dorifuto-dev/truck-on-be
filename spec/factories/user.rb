FactoryBot.define do
   factory :user do
     name { Faker::TvShows::Seinfeld.character }
     vehicle { Faker::Vehicle.make_and_model }
   end
end
