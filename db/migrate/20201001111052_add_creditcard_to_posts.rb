class AddCreditcardToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :creditcard, :integer, default: 0, null:false
  end
end
