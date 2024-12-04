class AddUserRoleToUser < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :user_role, :string, default: "CLIENT"
  end
end
