class AddElectronicMoneyToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :electronic_money, :integer, default: 0, null:false
  end
end
