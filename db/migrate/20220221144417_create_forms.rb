class CreateForms < ActiveRecord::Migration[6.1]
  def change
    create_table :forms do |t|
      t.string :name
      t.string :token
      t.integer :status, default: 0
      t.text :data

      t.timestamps
    end
  end
end
