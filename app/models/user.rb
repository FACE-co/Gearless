class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :gears, dependent: :destroy
  has_many :rentals, dependent: :destroy

  has_one_attached :avatar
  has_many :reviews, through: :rentals, dependent: :destroy
end
