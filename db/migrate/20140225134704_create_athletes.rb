class CreateAthletes < ActiveRecord::Migration
  def change
    create_table :athletes do |t|
      t.references :teacher, index: true
      t.string :first_name
      t.string :last_name
      t.integer :age
      t.string :gender
      t.integer :score

      t.timestamps
    end
  end
end
