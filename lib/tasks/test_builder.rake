namespace :db do
  namespace :test do
    task :prepare => :environment do
      puts "seeding Complexity"
      Complexity.delete_all
      Complexity.create(:level => "low")
      Complexity.create(:level => "medium")
      Complexity.create(:level => "higm")
    end
  end
end