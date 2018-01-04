class AddStatsToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :gave_actions, :integer
    add_column :users, :gave_advices, :integer
    add_column :users, :asked_actions, :integer
    add_column :users, :asked_advices, :integer
  end
end
