class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text :content
      t.string :picture
      t.string :store_name
      t.int :user_id

      t.timestamps
    end
  end
end
