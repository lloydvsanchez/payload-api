class ReservationDirector

  attr_accessor :parameters

  GUEST_COLS = %w(first_name last_name email phone_numbers).freeze
  RESERVATION_COLS = %w(code start_date end_date nights adults children infants status currency payout_price security_price).freeze

  private_constant :GUEST_COLS, :RESERVATION_COLS

  def initialize(params)
    @parameters = params
  end

  def get_guest
    builder_response(guest_builders, GUEST_COLS)
  end

  def get_reservation
    builder_response(reservation_builders, RESERVATION_COLS)
  end

  private

  def builder_response(builders, columns)
    builders.each do |klass|
      builder = klass.new(parameters)
      columns.each do |col|
        builder.send("set_#{col}")
      end

      return builder.response if builder.response.valid?

    end
    nil
  end

  def guest_builders
    klass_builders "GuestBuilder"
  end

  def reservation_builders
    klass_builders "ReservationBuilder"
  end

  def klass_builders(builder_type)
    Dir.glob("./app/services/#{builder_type.underscore}/*")
      .reject { |f| f.include?("base.rb") }
      .collect do |file|
        dir, basename = Pathname.new(file).split
        klass = basename.to_s.delete('.rb').camelize
        "#{builder_type}::#{klass}".constantize
      end
  end
end
