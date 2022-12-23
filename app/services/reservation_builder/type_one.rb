module ReservationBuilder
  class TypeOne < Base
    def initialize(parameters)
      super
      cols = %i(reservation_code start_date end_date nights adults children infants status currency payout_price security_price)
      @parameters = @parameters.permit(cols)
    rescue ActionController::ParameterMissing
      @parameters = nil
    end

    attr_accessor :code, :start_date, :end_date, :nights, :adults, :children,
                  :infants, :status, :currency, :payout_price, :security_price

    def set_code
      @code = dig(:reservation_code)
    end

    def set_start_date
      @start_date = dig(:start_date)&.to_date
    end

    def set_end_date
      @end_date = dig(:end_date)&.to_date
    end

    def set_nights
      @nights = dig(:nights)
    end

    def set_adults
      @adults = dig(:adults)
    end

    def set_children
      @children = dig(:children)
    end

    def set_infants
      @infants = dig(:infants)
    end

    def set_status
      @status = Reservation::STATUS[dig(:status)&.to_sym]
    end

    def set_currency
      @currency = dig(:currency)
    end

    def set_payout_price
      @payout_price = dig(:payout_price)
    end

    def set_security_price
      @security_price = dig(:security_price)
    end
  end
end
