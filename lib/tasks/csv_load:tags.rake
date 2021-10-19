require 'csv'

namespace :csv_load do
  desc "Imports Tags CSV file into an ActiveRecord table"
  task :tags => :environment do
    Tag.destroy_all
    file = './db/data/tags.csv'
    CSV.foreach(file, :headers => true, header_converters: :symbol) do |row|
      Tag.create!(row.to_hash)
    end
    ActiveRecord::Base.connection.reset_pk_sequence!(:tags)
  end
end
