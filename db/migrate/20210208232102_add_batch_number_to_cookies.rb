class AddBatchNumberToCookies < ActiveRecord::Migration[5.1]
  def change
    add_column :cookies, :batch_number, :integer
    add_index :cookies, :batch_number
  end
end
