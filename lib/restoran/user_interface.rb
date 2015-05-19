module Restoran
  module UserInterface
    def show_startup_info
      p "Restoran reservation app".upcase.center(76, '-')
      reservation_count = Reservation.count
      show_table if reservation_count > 0
      p '-'.center(76, '-')
      show_guide
    end

    def unknown_line_format
      p 'Can not understand command format'
      show_guide
    end


    def show_guide
      p "\n".chomp
      p 'How to use:'
      p '-'.center(76, '-')
      p 'Insert new reservation format: i <table_number> <start_date> <end_date>'
      p 'Example: i 2 2013-08-23 2013-08-24'
      p 'Delete reservation format: d <id>'
      p 'Example: d 1'
      p 'Update reservation format: u <id> <table_number> <start_date> <end_date>'
      p 'Example: u 1 2 2013-08-23 2013-08-24'
      p 'Show guide again: h'
      p 'Exit: q'
      p '-'.center(76, '-')
    end

    def show_table
      show_table_header
      Reservation.all.each do |reserve|
        show_table_row([
          reserve.id,
          reserve.table_number,
          reserve.book_start.strftime('%F'),
          reserve.book_end.strftime('%F')
        ])
      end
    end

    def show_table_header
      p 'Current reservation status'.upcase.center(76, '-')
      p "\n".chomp
      p '-'.center(76, '-')
      show_table_row(['id', 'table number', 'start', 'end'])
      p '-'.center(76, '-')
    end

    def show_table_row(columns_data)
      p "| #{columns_data[0]}".ljust(19, ' ') +
        "| #{columns_data[1]}".ljust(19, ' ') +
        "| #{columns_data[2]}".ljust(19, ' ') +
        "| #{columns_data[3]}".ljust(19, ' ') + '|'
    end
  end
end
