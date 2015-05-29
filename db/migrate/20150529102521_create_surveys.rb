class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :title, null:USer     false
      t.integer :creator_id, null: false

      t.timestamps null: false
    end
  end
end
