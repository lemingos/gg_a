class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :email
      t.integer :campaign_count, default: 0
      t.index :email, unique: true

      t.timestamps
    end
  end
end
