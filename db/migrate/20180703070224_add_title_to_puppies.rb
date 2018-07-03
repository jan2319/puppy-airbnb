class AddTitleToPuppies < ActiveRecord::Migration[5.2]
  def change
    add_column :puppies, :title, :string
  end
end
