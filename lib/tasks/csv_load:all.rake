namespace :csv_load do
  desc "Create seed files for all CSV"
  task :all => :environment do
    Rake::Task["csv_load:trails"].invoke
    Rake::Task["csv_load:tags"].invoke
    Rake::Task["csv_load:trail_tags"].invoke
  end
end
