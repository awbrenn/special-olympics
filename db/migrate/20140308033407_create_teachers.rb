class CreateTeachers < ActiveRecord::Migration
  def change
    create_table :teachers do |t|
      t.string :name
      t.references :group, index: true

      t.timestamps
    end
  end
end
