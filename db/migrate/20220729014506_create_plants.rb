class CreatePlants < ActiveRecord::Migration[5.2]
  def change
    create_table :plants do |t|
      t.string :name
      t.string :plant_id
      t.datetime :date_planted
      t.text :moon_phase
      t.datetime :date_matured
      t.integer :bounty_amount
      t.text :pruning_behaviors
      t.text :notes
      t.references :garden_id, foreign_key: true

      t.timestamps
    end
  end
end
