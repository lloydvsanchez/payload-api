require "test_helper"

class ReservationTest < ActiveSupport::TestCase
  def setup
    @reservation = reservations(:type_one)
  end

  test 'valid reservation' do
    assert @reservation.valid?
  end

  test 'invalid without start_date' do
    @reservation.start_date = nil
    assert_not @reservation.valid?
  end

  test 'invalid without end_date' do
    @reservation.end_date = nil
    assert_not @reservation.valid?
  end

  test 'invalid without adults' do
    @reservation.adults = nil
    assert_not @reservation.valid?
  end

  test 'invalid with payout_price less than zero or nil' do
    @reservation.payout_price = nil
    assert_not @reservation.valid?

    @reservation.payout_price = 0
    assert @reservation.valid?

    @reservation.payout_price = -1
    assert_not @reservation.valid?
  end

  test 'invalid without uniq code' do
    two = reservations(:type_two)
    two.update(code: @reservation.code)
    assert_not two.valid?
  end

  test 'belongs_to references' do
    assert_equal guests(:john), @reservation.guest
  end

  test 'total guests' do
    total = @reservation.adults + @reservation.children + @reservation.infants
    assert_equal total, @reservation.guests
  end

  test 'total price' do
    total = @reservation.payout_price + @reservation.security_price
    assert_equal total, @reservation.total_price
  end
end
