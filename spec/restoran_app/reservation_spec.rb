describe Reservation do
  before(:each) do
    Reservation.create(
      table_number: 1,
      book_start: Time.now,
      book_end: (Time.now + 1.day)
    )
  end

  it 'checks not overlapped table reservation' do
    new_reservation = Reservation.new(
      table_number: 1,
      book_start: Time.now - 2.day,
      book_end: Time.now - 1.day
    )
    new_reservation.valid?
    expect(new_reservation.errors.messages).not_to include(:overlapping)
  end

  it 'checks overlapped table reservation (error case)' do
    new_reservation = Reservation.new(
      table_number: 1,
      book_start: Time.now,
      book_end: (Time.now + 1.day)
    )
    new_reservation.valid?
    expect(new_reservation.errors.messages).to include(:overlapping)
  end

end

