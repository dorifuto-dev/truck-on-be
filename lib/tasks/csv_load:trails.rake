require 'csv'

namespace :csv_load do
  desc "Imports Trails CSV file into an ActiveRecord table"
  task :trails => :environment do
    Trail.destroy_all
    file = './db/data/trails.csv'
    CSV.foreach(file, :headers => true) do |row|
      Trail.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(:trails)
  end
end
