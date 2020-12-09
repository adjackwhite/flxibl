class CreateProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :profiles do |t|
      t.string :profession
      t.text :bio
      t.integer :lowest_day_rate
      t.integer :highest_day_rate
      t.string :location
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
