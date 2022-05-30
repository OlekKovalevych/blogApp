class User < ApplicationRecord
  has_many :articles, dependent: :destroy

  validates :name, presence: true
  validates :surname, presence: true

  def admin?(user)
    user.is_admin
  end
end
