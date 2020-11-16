class CreateUsersCampaigns < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :campaigns do |t|
      t.index :user_id
      t.index :capmaign_id
    end
  end
end
