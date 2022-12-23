require "test_helper"

class GuestTest < ActiveSupport::TestCase
  def setup
    @guest = guests(:john)
  end

  test 'valid guest' do
    assert @guest.valid?
  end

  test 'invalid without first_name' do
    @guest.first_name = nil
    assert_not @guest.valid?
  end

  test 'invalid without last_name' do
    @guest.last_name = nil
    assert_not @guest.valid?
  end

  test 'invalid without uniq email' do
    jane = guests(:jane)
    jane.update(email: @guest.email)
    assert_not jane.valid?

    jane.email = nil
    assert_not jane.valid?
  end

  test 'guest references count' do
    assert_equal 2, @guest.reservations.count
  end
end
