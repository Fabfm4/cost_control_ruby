class User < ApplicationRecord
  enum :user_role, { client: "CLIENT", admin: "ADMIN" }, suffix: true

  has_many :cards

  validates :user_name, uniqueness: true
  validates :email, uniqueness: true
end
