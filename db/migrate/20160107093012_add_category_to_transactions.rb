class AddCategoryToTransactions < ActiveRecord::Migration
  def change
    add_column :transactions, :category, :string, default: nil
  end
end
