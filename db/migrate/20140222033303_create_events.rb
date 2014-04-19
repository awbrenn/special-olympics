class CreateEvents < ActiveRecord::Migration

  def change
    create_table :events do |t|
      t.string :event_code
      t.string :event_name
      t.string :score_unit
      t.integer :min_score
      t.integer :max_score
      t.integer :sort_seq

      t.timestamps
    end
  end
end
