class User < ApplicationRecord
  has_many :articles, dependent: :destroy

  validates :name, presence: true
  validates :surname, presence: true


  
end
