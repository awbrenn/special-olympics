class CreateHeats < ActiveRecord::Migration
  def change
    create_table :heats do |t|
      t.references :event, index: true
      t.string :gender
      t.integer :min_age
      t.integer :max_age
      t.string :time
      t.integer :num_heats

      t.timestamps
    end

  end
end
