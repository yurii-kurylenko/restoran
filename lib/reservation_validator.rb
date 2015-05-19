class ReservationValidator
  def initialize(reservation)
    @reservation = reservation
  end

  def validate
    overlapped_with = check_overlapping
    if overlapped_with
      msg = "Overlaping with table #{overlapped_with.table_number}, \
       time frame: [#{overlapped_with.book_start}.. \
       #{overlapped_with.book_end}]"
      @reservation.errors[:base] << msg
    end
    @reservation.errors[:base] << 'Start date is greater than end date' unless dates_valid?
  end

  private

  def check_overlapping
    overlapped_with = nil
    Reservation.all.each do |reserv|
      if (@reservation.book_start < reserv.book_end) &&
          (@reservation.book_end > reserv.book_start) &&
          (@reservation.table_number == reserv.table_number)
        overlapped_with = reserv
        break
      end
    end
    overlapped_with
  end

  def dates_valid?
    @reservation.book_start < @reservation.book_end
  end
end
