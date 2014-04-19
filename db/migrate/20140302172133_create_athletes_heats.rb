class CreateAthletesHeats < ActiveRecord::Migration
  def self.up
    create_table :athletes_heats, :id => false do |t|
    	t.references :athlete
    	t.references :heat
    end
    add_index :athletes_heats, [:athlete_id, :heat_id]
    add_index :athletes_heats, :heat_id
  end

  def self.down
  	drop_table :athletes_heats
  end
end
