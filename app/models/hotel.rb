class Hotel < ApplicationRecord
  belongs_to :user
  has_may :rooms, dependent: :destroy
end
