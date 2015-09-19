class AddMondoIdToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :mondo_id, :string, null: false
    add_index :accounts, :mondo_id, unique: true
  end
end
