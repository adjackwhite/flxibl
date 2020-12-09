class CreateWebsiteLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :website_links do |t|
      t.references :profile, null: false, foreign_key: true
      t.string :url
      t.string :label

      t.timestamps
    end
  end
end
