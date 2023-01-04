class RemoveTemperatureFromTea < ActiveRecord::Migration[5.2]
  def change
    remove_column :teas, :temperature, :float
  end
end
