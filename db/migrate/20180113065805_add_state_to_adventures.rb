class AddStateToAdventures < ActiveRecord::Migration[5.1]
  def change
    add_column :adventures, :state, :string
  end
end
