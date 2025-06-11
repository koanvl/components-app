class AddRoleAndProfileToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :role, :integer
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :company_name, :string
    add_column :users, :bio, :text
    add_column :users, :professional_title, :string
  end
end
