class CreateAdventures < ActiveRecord::Migration[5.1]
    def change
        create_table 'adventures' do |t|
            t.string 'number_of_people'
            t.string 'action_adventure'
            t.string 'country'
            t.string 'city'
            t.string 'description'
            t.string 'details'
            t.datetime 'adventure_date'
            t.float 'price'
            t.datetime 'created_at'


        end
        add_reference :adventures, :user, foreign_key: true
    end
end
