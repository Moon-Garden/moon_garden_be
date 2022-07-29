class CreateGardens < ActiveRecord::Migration[5.2]
  def change
    create_table :gardens do |t|
      t.string :name
      t.string :cardinal_direction
      t.string :notes
    end
  end
end
