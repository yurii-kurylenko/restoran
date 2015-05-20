class DatabaseConnection
  RESERVATION_TABLE = 'reservations'

  def self.check_migration
    begin
      ActiveRecord::Base.connection
    rescue Exception => e
      return false
    end
    return false unless ActiveRecord::Base.connection.table_exists? RESERVATION_TABLE
    true
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