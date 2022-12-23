module GuestBuilder
  class TypeOne < Base

    def initialize(parameters)
      super
      @parameters = @parameters.require(:guest).permit(:first_name, :last_name, :email, :phone)
    rescue ActionController::ParameterMissing
      @parameters = nil
    end

    def set_first_name
      @first_name = dig(:first_name)
    end

    def set_last_name
      @last_name = dig(:last_name)
    end

    def set_email
      @email = dig(:email)
    end

    def set_phone_numbers
      @phone_numbers = [dig(:phone)]
    end
  end
end
