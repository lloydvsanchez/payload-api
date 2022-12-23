module GuestBuilder
  class TypeTwo < Base

    def initialize(parameters)
      super
      @parameters = @parameters.require(:reservation)
                               .permit(:guest_email,     :guest_first_name,
                                       :guest_last_name, guest_phone_numbers: [])
    rescue ActionController::ParameterMissing
      @parameters = nil
    end

    def set_first_name
      @first_name = dig(:guest_first_name)
    end

    def set_last_name
      @last_name = dig(:guest_last_name)
    end

    def set_email
      @email = dig(:guest_email)
    end

    def set_phone_numbers
      @phone_numbers = dig(:guest_phone_numbers)
    end
  end
end
