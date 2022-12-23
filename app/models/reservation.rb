class Reservation < ApplicationRecord
  belongs_to :guest, optional: true

  before_create :set_code
  before_save :set_end_date
  before_save :set_nights

  validates_presence_of :code, if: :persisted?
  validates_presence_of :guest, if: :persisted?

  validates_presence_of :start_date
  validates_presence_of :end_date
  validates_presence_of :adults
  validates :payout_price, numericality: { greater_than_or_equal_to: 0 }
  validates :code, uniqueness: true

  STATUS = { pending: 0, accepted: 1, denied: 2 }.freeze

  def status_str
    STATUS.invert[self.status]
  end

  def guests
    (adults || (guest.present? ? 1 : 0)) + (children || 0) + (infants || 0)
  end

  def total_price
    (payout_price || 0.0) + (security_price || 0.0)
  end

  private

  def set_code
    self.code ||= SecureRandom.alphanumeric(16)
  end

  def set_end_date
    self.end_date ||= (start_date + ( nights * 24.hours )) if end_date.blank? && nights.present?
  end

  def set_nights
    self.nights = (end_date - start_date).to_i if end_date.present? && start_date.present?
  end
end
