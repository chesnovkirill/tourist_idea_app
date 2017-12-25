class AddNameToUsers < ActiveRecord::Migration[5.1]
  def change
      add_column :users, :first_name, :string
      add_column :users, :last_name, :string
      add_column :users, :gender, :string
      add_column :users, :date_of_birth, :datetime
      add_column :users, :country_of_residence, :string
      add_column :users, :city_of_residence, :string
      add_column :users, :contact_phone, :string
      add_column :users, :education, :string
      add_column :users, :work, :string
      add_column :users, :interests, :string
      add_column :users, :capabilities, :string
      add_column :users, :admin, :boolean 
  end
end
