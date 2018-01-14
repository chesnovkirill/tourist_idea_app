class AddPaymentToAdventures < ActiveRecord::Migration[5.1]
  def change
    add_column :adventures, :method, :string
  end
end
