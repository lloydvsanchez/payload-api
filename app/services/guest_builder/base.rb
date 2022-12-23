module GuestBuilder
  class Base
    attr_accessor :first_name, :last_name, :email, :phone_numbers

    def initialize(parameters)
      @parameters = parameters
    end

    def set_first_name
      raise NotImplementedError
    end

    def set_last_name
      raise NotImplementedError
    end

    def set_email
      raise NotImplementedError
    end

    def set_phone_numbers
      raise NotImplementedError
    end

    def response
      return nil if parameters.nil?

      guest = Guest.find_by(email: email) if email.present?

      guest.present? ? assign_to(guest) : build
    end

    private

    def parameters
      @parameters
    end

    def dig(key)
      parameters&.dig(key)
    end

    def build
      assign_to(Guest.new)
    end

    def assign_to(obj)
      obj.assign_attributes({
        first_name:    first_name,
        last_name:     last_name,
        email:         email,
        phone_numbers: phone_numbers
      })
      obj
    end
  end
end
