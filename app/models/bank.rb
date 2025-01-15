class Bank < ApplicationRecord
  belongs_to :user

  validates :name, presence: true

  def self.get_bank_list_by_user(user, params = {})
    active = params[:active] || true
    where(user: user, active: active)
  end

  def self.get_bank_retrieve_by_id(id, user)
    find_by!(id: id, user: user)
  end

  def self.create_bank(params)
    model = new(params)
    model.save
    model
  end

  def self.update_bank_by_id(id, user, params)
    model = get_bank_retrieve_by_id(id, user)
    model.update(params)
    model
  end

  def self.delete_bank_by_id(id, user)
    model = get_bank_retrieve_by_id(id, user)
    model.update(active: false)
  end
end
