class RemoveHighestDayRateFromProfiles < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :highest_day_rate, :integer
  end
end
