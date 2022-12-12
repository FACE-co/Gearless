class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :gear
  has_many :reviews
  validates :status, inclusion: { in: ['confirmed', 'pending', 'completed', 'cancelled'] }
  validates :start_date, :end_date, presence: true
  # validate :validate_rent_time

  def validate_rent_time
    if self.end_date <= self.start_date
      errors.add("Your start date can't be later than end date!")
    elsif self.start_date < Time.now
      errors.add("Start from a date after today!")
    end
  end
end
