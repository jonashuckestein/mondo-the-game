class CreateMerchants < ActiveRecord::Migration
  def change
    create_table :merchants, id: :uuid do |t|
      t.string :mondo_id, null: false
      t.jsonb :mondo_data, null: false
      t.timestamps null: false
    end
    add_index :merchants, :mondo_id, unique: true
  end
end
