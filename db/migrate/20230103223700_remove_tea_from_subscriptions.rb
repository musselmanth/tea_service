class RemoveTeaFromSubscriptions < ActiveRecord::Migration[5.2]
  def change
    remove_reference :subscriptions, :tea, foreign_key: true
  end
end
