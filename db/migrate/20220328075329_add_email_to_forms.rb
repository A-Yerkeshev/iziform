class AddEmailToForms < ActiveRecord::Migration[6.1]
  def change
    add_column :forms, :email, :string
  end
end
