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

            add_reference :preferences, :user, foreign_key: true
        end
    end
end
