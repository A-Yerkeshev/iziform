class CreateResponses < ActiveRecord::Migration[6.1]
  def change
    create_table :responses do |t|
      t.int :form_id
      t.text :content
      t.string :respondent

      t.timestamps
    end
  end
end
