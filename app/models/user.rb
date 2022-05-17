class User < ApplicationRecord
  has_many :articles

  validates :name, presence: true
  validates :surname, presence: true
end
