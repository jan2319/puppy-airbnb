class CreatePuppies < ActiveRecord::Migration[5.2]
  def change
    create_table :puppies do |t|
      t.string :photo_url
      t.string :name
      t.text :description
      t.string :street
      t.string :zipcode
      t.string :city
      t.string :country
      t.integer :daily_price
      t.datetime :birthdate
      t.integer :toilet_training_level
      t.references :user, foreign_key: true
      t.references :breed, foreign_key: true

      t.timestamps
    end
  end
end
