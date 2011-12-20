class CreateStudyeggs < ActiveRecord::Migration
  def change
    create_table :studyeggs do |t|
      t.integer :price
      t.integer :qb_studyegg_id
      t.text :description

      t.timestamps
    end
  end
end
