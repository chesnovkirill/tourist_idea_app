class AddAdventureToChatRooms < ActiveRecord::Migration[5.1]
  def change
    add_column :chat_rooms, :adventure, :integer
  end
end
