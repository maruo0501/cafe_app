class Rename < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :image, :picture
  end
end
