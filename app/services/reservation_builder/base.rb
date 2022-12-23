module ReservationBuilder
  class Base
    attr_accessor :code, :start_date, :end_date, :nights, :adults, :children,
                  :infants, :status, :currency, :payout_price, :security_price

    def initialize(parameters)
      @parameters = parameters
    end

    def set_code
      raise NotImplementedError
    end

    def set_start_date
      raise NotImplementedError
    end

    def set_end_date
      raise NotImplementedError
    end

    def set_nights
      raise NotImplementedError
    end

    def set_adults
      raise NotImplementedError
    end

    def set_children
      raise NotImplementedError
    end

    def set_infants
      raise NotImplementedError
    end

    def set_status
      raise NotImplementedError
    end

    def set_currency
      raise NotImplementedError
    end

    def set_payout_price
      raise NotImplementedError
    end

    def set_security_price
      raise NotImplementedError
    end

    def response
      return nil if parameters.nil?

      reservation = Reservation.find_by(code: code) if code.present?

      reservation.present? ? assign_to(reservation) : build
    end

    private

    def parameters
      @parameters
    end

    def dig(keys)
      keys = [keys] unless keys.is_a? Array
      parameters&.dig(*keys)
    end

    def build
      assign_to(Reservation.new)
    end

    def assign_to(obj)
      obj.assign_attributes({
        code:           code,
        start_date:     start_date,
        end_date:       end_date,
        nights:         nights,
        adults:         adults,
        children:       children,
        infants:        infants,
        status:         status,
        currency:       currency,
        payout_price:   payout_price,
        security_price: security_price
      })
      obj
    end
  end
end
