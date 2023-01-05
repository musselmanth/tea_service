class AddTemperatureToTea < ActiveRecord::Migration[5.2]
  def change
    add_column :teas, :temperature, :integer
  end
end
