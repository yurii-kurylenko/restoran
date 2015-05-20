namespace :db do
  task :migrate  do
    require 'db/migrate/create_reservations'
    CreateReservations.new.change unless DatabaseConnection.check_migration
  end

  task :purge do
    Reservation.all.each(&:destroy)
  end
end