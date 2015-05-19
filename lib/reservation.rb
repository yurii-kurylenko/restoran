class Reservation < ActiveRecord::Base
  validates :book_start, presence: true
  validates :book_end, presence: true
  validates :table_number, presence: true

  validate do |reservation|
    ReservationValidator.new(reservation).validate
  end

end