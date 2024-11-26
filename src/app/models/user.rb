class User < ApplicationRecord
  has_many :cards

  validates :user_name, uniqueness: true
  validates :email, uniqueness: true
end
