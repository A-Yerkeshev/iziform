class CreateQuestions < ActiveRecord::Migration[6.1]
  def change
    create_table :questions do |t|
      t.integer :form_id
      t.text :content
      t.text :options
      t.string :question_type

      t.timestamps
    end
  end
end
