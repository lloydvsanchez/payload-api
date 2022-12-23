module ReservationBuilder
  class TypeTwo < Base
    def initialize(parameters)
      super
      cols = [:code, :start_date, :end_date, :expected_payout_amount, { guest_details: %i(localized_description number_of_adults number_of_children number_of_infants) }, :listing_security_price_accurate, :host_currency, :nights, :number_of_guests, :status_type]
      @parameters = @parameters.require(:reservation).permit(cols)
    rescue ActionController::ParameterMissing
      @parameters = nil
    end

    attr_accessor :code, :start_date, :end_date, :nights, :adults, :children,
                  :infants, :status, :currency, :payout_price, :security_price

    def set_code
      @code = dig(:code)
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
      # note: if no adults in guest_details, assume number_of_guests are adults
      @adults = dig([:guest_details, :number_of_adults]) || dig(:number_of_guests)
    end

    def set_children
      @children = dig([:guest_details, :number_of_children])
    end

    def set_infants
      @infants = dig([:guest_details, :number_of_infants])
    end

    def set_status
      @status = Reservation::STATUS[dig(:status_type)&.to_sym]
    end

    def set_currency
      @currency = dig(:host_currency)
    end

    def set_payout_price
      @payout_price = dig(:expected_payout_amount)
    end

    def set_security_price
      @security_price = dig(:listing_security_price_accurate)
    end
  end
end
