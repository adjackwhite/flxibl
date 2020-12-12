class RemoveLowestDayRateFromProfiles < ActiveRecord::Migration[6.0]
  def change
    remove_column :profiles, :lowest_day_rate, :integer
  end
end
