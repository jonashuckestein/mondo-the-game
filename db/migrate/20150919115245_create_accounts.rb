class CreateAccounts < ActiveRecord::Migration
  def change
    enable_extension 'uuid-ossp'
    create_table :accounts, id: :uuid do |t|
      t.string :email
      t.string :access_token, null: false

      t.integer :points, null: false

      t.timestamps null: false
    end
  end
end
