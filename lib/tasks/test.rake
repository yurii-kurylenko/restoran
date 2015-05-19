namespace :test do
  task :prepare do
    Rake::Task["db:migrate"].invoke unless DatabaseConnection.check_migration
    Rake::Task["db:purge"].invoke
  end
end
