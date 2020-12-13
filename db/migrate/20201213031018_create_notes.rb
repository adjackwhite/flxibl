class CreateNotes < ActiveRecord::Migration[6.0]
  def change
    create_table :notes do |t|
      t.text :content
      t.references :profile, null: false, foreign_key: true

      t.timestamps
    end
  end
end