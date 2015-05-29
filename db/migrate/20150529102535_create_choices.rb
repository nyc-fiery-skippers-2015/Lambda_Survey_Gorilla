class CreateChoices < ActiveRecord::Migration
  def change
    create_table :choices do |t|
      t.string :choice, null: false
      t.integer :question_id, null: false

      t.timestamps null: false
    end
  end
end
