class Guest < ApplicationRecord
  has_many :reservations

  serialize :phone_numbers

  after_initialize do |g|
    g.phone_numbers = [] if g.phone_numbers.nil?
  end

  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :email
  validates :email, uniqueness: true
end
