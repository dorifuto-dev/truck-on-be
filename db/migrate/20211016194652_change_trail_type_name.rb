class ChangeTrailTypeName < ActiveRecord::Migration[5.2]
  def change
    rename_column :trails, :type, :route_type
  end
end
