class AddColumnsToAdventures < ActiveRecord::Migration[5.1]
  def change
    add_column :adventures, :paid, :boolean
    add_column :adventures, :inviter, :integer
    add_column :adventures, :earned, :float
    add_column :adventures, :conducted_by, :integer
    add_column :adventures, :rating, :integer
  end
end
