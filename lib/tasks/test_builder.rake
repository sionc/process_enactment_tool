namespace :db do
  namespace :test do
    task :prepare => :environment do
      puts "Seeding Test Database..."
      Complexity.delete_all
      Complexity.create(:level => "low")
      Complexity.create(:level => "medium")
      Complexity.create(:level => "high")
    end
  end
end