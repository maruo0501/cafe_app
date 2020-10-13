class CreatePosts < ActiveRecord::Migration[6.0]
  def change
    create_table :posts do |t|
      t.text :content
      t.string :picture
      t.string :store_name
      t.integer :user_id

      # 追記
      t.integer :wifi, default: 0, null: false
      t.integer :power, default: 0, null: false
      t.integer :creditcard, default: 0, null: false

      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
