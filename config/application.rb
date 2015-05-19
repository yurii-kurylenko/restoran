require 'active_record'
require 'rake'
require 'mysql2'
require 'pry'
require 'yaml'
require 'singleton'

APP_ROOT = "#{File.dirname(__FILE__)}/.."

$LOAD_PATH.unshift(APP_ROOT)

config = YAML::load_file("#{APP_ROOT}/config/database.yml")['development']

require 'lib/database_connection'

db = DatabaseConnection.new(config)
db.connect

require 'lib/reservation'
require 'lib/reservation_validator'
require 'lib/restoran/user_interface'
require 'lib/restoran_app'
