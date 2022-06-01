# frozen_string_literal: true

class User < ApplicationRecord
  before_validation :set_is_admin, on: %i[create save]
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :articles, dependent: :destroy

  validates :name, presence: true
  validates :surname, presence: true

  def admin?
    is_admin
  end
end

private

def set_is_admin
  @is_admin ||= false
end
