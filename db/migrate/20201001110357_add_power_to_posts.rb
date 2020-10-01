class AddPowerToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :power, :integer, default: 0, null:false
  end
end
