class Campaign < ApplicationRecord
  has_and_belongs_to_many :users

  validates :subject, presence: true, length: { maximum: 255 }
  validates :message, presence: true

  def users=users_emails
    users << User.where(email: users_emails)
  end

  def increase_user_campaign_counters!
    users.update_all('campaign_count = campaign_count + 1')
  end

end
