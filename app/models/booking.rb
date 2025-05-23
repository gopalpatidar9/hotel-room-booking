class Booking < ApplicationRecord
  belongs_to :room  
  belongs_to :user
  has_one :payment, dependent: :destroy
  
  before_save :calculate_total_price
  validate :end_after_start
  enum :payment_method, { card: 0, upi: 1 }
  enum :payment_status, { pending: 0, paid: 1, failed: 2, refunded: 3 }
  
  private
  
  def calculate_total_price
    nights = (end_date.to_date - start_date.to_date).to_i
    nights = 1 if nights < 1
    base_price = nights * room.price_per_night
    if base_price < 7500
      self.gst = (base_price * 0.12).round(2)
    else 
      self.gst = (base_price * 0.18).round(2)
    end
    self.total_price = base_price + gst
  end

  def end_after_start
    if end_date.present? && start_date.present? && end_date <= start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

end
