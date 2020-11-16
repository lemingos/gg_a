class CreateCampaigns < ActiveRecord::Migration[6.0]
  def change
    create_table :campaigns do |t|
      t.string :subject
      t.text :message

      t.timestamps
    end
  end
end
