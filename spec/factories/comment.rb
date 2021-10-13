FactoryBot.define do
   factory :comment do
     content { Faker::TvShows::MichaelScott.quote }
     user
     trail

   end
end
