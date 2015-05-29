class CreateTakenSurveys < ActiveRecord::Migration
  def change
    create_table :taken_surveys do |t|
      t.integer :user_id, null: false
      t.integer :survey_id, null: false

      t.timestamps null: false
    end
  end
end
