class CreateChoicesUsers < ActiveRecord::Migration
  def change
    create_table :choices_users do |t|
      t.integer :user_id, null: false
      t.integer :choice_id, null: false

      t.timestamps null: false
    end
  end
end
