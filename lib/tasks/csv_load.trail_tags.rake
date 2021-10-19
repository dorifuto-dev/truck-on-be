require 'csv'

namespace :csv_load do
  desc "Imports Trail Tags CSV file into an ActiveRecord table"
  task :trail_tags => :environment do
    TrailTag.destroy_all
    file = './db/data/trail_tags.csv'
    CSV.foreach(file, :headers => true, header_converters: :symbol) do |row|
      TrailTag.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(:trail_tags)
  end
end
