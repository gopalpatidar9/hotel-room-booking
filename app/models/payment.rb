class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :booking  

  enum :pay_method, { card: 0, upi: 1 }
  enum :pay_status, { pending: 0, paid: 1, failed: 2, refunded: 3 }

  before_save :set_amount
  before_save :set_paid_time
  after_create :set_paid_payment_status, if: :assume_success?

  private

  def set_amount
    self.amount = booking.total_price
  end
  
  def set_paid_time
    self.paid_at = Time.current
  end

  def set_paid_payment_status
    update(pay_status: :paid)
  end

  def assume_success?
    true
  end
end
