class CreateLessons < ActiveRecord::Migration
  def change
    create_table :lessons do |t|
      t.integer :price
      t.integer :qb_lesson_id

      t.timestamps
    end
  end
end
