class RestoranApp
  include Restoran::UserInterface

  COMMANDS = ['i', 'u', 'd', 'h' ,'q']

  def initalize
    @exit = false
  end

  def init!
    check_migration
    return if @exit
    show_startup_info
    until @exit
      print '> '.chomp
      process_command(gets)
    end
  end

  private

  def process_command(line)
    line_attrs = line.split
    return unknown_line_format unless COMMANDS.include?(line_attrs[0])
    case line_attrs[0]
    when 'i'
      insert_reservation(line_attrs)
    when 'u'
      update_reservation(line_attrs)
    when 'd'
      delete_reservation(line_attrs)
    when 'h'
      show_guide
    when 'q'
      @exit = true
    end
  end

  def insert_reservation(line_attrs)
    return unknown_line_format unless line_attrs.count == 4
    date_error = check_dates(line_attrs[2], line_attrs[3])
    return date_error unless date_error.empty?
    reservation = Reservation.new(
      table_number: line_attrs[1],
      book_start: line_attrs[2],
      book_end: line_attrs[3]
    )
    if reservation.save
      p 'Table booked!'
      show_table
    else
      show_reservation_error(reservation)
    end
  end

  def delete_reservation(line_attrs)
    return unknown_line_format unless line_attrs.count == 2
    reservation = Reservation.where(id: line_attrs[1]).first
    if reservation
      reservation.destroy
      p 'Reservation deleted'
      show_table
    else
      p 'Record not found'
      show_table
    end
  end

  def update_reservation(line_attrs)
    return unknown_line_format unless line_attrs.count == 5
    date_error = check_dates(line_attrs[2], line_attrs[3])
    return date_error unless date_error.empty?
    reservation = Reservation.where(id: line_attrs[1]).first
    if reservation
      reservation.table_number = line_attrs[2]
      reservation.book_start = line_attrs[3]
      reservation.book_end = line_attrs[4]
      if reservation.save
        p 'Reservation updated'
        show_table
      else
        show_reservation_error(reservation)
      end
    else
      p 'Record not found'
      show_table
    end
  end

  def check_migration
    message = DatabaseConnection.check_migration
    unless message.blank?
      p message
      @exit = true
    end
  end

  def show_reservation_error(reservation)
    p 'ERRORS:'
    p reservation.errors.messages[:base].first
    p '-'.center(76, '-')
    show_table
  end

  def check_dates(start, finish)
    date_start = Date.strptime(start, '%Y-%m-%d')
    date_finish = Date.strptime(finish, '%Y-%m-%d')
    ''
  rescue
    p 'Error in date format, use YYYY-MM-DD'
    return 'Error in date format, use YYYY-MM-DD'
  end
end
