class DatabaseConnection
  RESERVATION_TABLE = 'reservations'

  def self.check_migration
    return if ActiveRecord::Base.connection.table_exists? RESERVATION_TABLE
    begin
      ActiveRecord::Base.connection
    rescue Exception => e
      return 'No connection to database'
    end
    'Please, run rake db:migrate create table for reservations'
  end

  def initialize(config)
    @config = config
  end

  def connect
    create_database
    ActiveRecord::Base.establish_connection(@config)
  end

  def create_database
    config_without_database = @config.except('database')
    ActiveRecord::Base.establish_connection(config_without_database)
    return true if ActiveRecord::Base.connection.select_values('show databases;').include?(@config['database'])
    ActiveRecord::Base.connection.create_database @config['database']
  end


end