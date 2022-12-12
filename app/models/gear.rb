class Gear < ApplicationRecord
  include PgSearch::Model
  belongs_to :user

  pg_search_scope :search_by_gear_attribute,
    against: [ :gear_type, :gear_name, :summary ],
    using: {
      tsearch: { prefix: true }
    }

  has_many :rentals, dependent: :destroy
  has_many :reviews, through: :rentals, dependent: :destroy
  has_many_attached :photos

  # validates :gear_name, presence: true
  validates :gear_type, presence: true
  validates :gear_type, inclusion: { in: %w(Hiking Rock-Climbing Cooking Sleeping Kayak Navigation Shelter Sleeping-Bags Hydration Navigation First-Aid Survival Illumination Repair-Kits) }
  validates :address, presence: true
  validates :price, presence: true

  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?
end
