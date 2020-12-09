class CreateNetworks < ActiveRecord::Migration[6.0]
  def change
    create_table :networks do |t|
      t.references :user, null: false, foreign_key: true
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end
