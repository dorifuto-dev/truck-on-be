require 'csv'

namespace :csv_load do
  desc "Imports Trails CSV file into an ActiveRecord table"
  task :trails => :environment do
    Trail.destroy_all
    file = './db/data/trails.csv'
    CSV.foreach(file, :headers => true, header_converters: :symbol) do |row|
      hash = row.to_hash
      hash[:difficulty] = hash[:difficulty].to_i
      hash[:route_type] = hash[:route_type].to_i
      hash[:traffic] = hash[:traffic].to_i
      Trail.create!(hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(:trails)
  end
end
