class CreateHeatSheetGenerators < ActiveRecord::Migration
  def change
    create_table :heat_sheet_generators do |t|

      t.timestamps
    end
  end
end
