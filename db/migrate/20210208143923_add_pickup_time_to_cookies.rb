class AddPickupTimeToCookies < ActiveRecord::Migration[5.1]
  def change
    add_column :cookies, :pickup_time, :datetime
  end
end
