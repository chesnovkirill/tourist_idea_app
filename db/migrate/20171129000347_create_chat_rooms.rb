class CreateChatRooms < ActiveRecord::Migration[5.1]
  def change
    create_table :chat_rooms do |t|
      t.integer 'user_id', :reference => "user"
      t.integer 'host_id', :reference => "user"
      t.timestamps
    end
  end
end
