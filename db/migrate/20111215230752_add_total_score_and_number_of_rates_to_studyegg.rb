class AddTotalScoreAndNumberOfRatesToStudyegg < ActiveRecord::Migration
  def change
    add_column :studyeggs, :total_score, :integer, :default => 0
    add_column :studyeggs, :number_of_rates, :integer, :default => 0
  end
end
