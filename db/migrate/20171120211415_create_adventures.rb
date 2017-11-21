class CreateAdventures < ActiveRecord::Migration[5.1]
    def change
        create_table 'adventures' do |t|
            t.string 'number_of_people'
            t.string 'country'
            t.string 'city'
            t.string 'description'
            t.string 'details'
            t.datetime 'adventure_date'
            t.float 'price'
            # Add fields that let Rails automatically keep track
            # of when movies are added or modified:
            t.timestamps
        end
    end
end
