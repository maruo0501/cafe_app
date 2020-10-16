class AddUserIdToPosts < ActiveRecord::Migration[6.0]
  def change
    rails db:environment:set RAILS_ENV=test
  end
end
