class CreateTrails < ActiveRecord::Migration[5.2]
  def change
    create_table :trails do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.integer :elevation_gain
      t.text :description
      t.integer :difficulty
      t.integer :type
      t.integer :traffic
      t.string :nearest_city
      t.integer :distance

      t.timestamps
    end
  end
end
