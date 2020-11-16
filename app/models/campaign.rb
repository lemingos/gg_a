class Campaign < ApplicationRecord
  has_and_belongs_to_many :users

  validates :subject, presence: true, length: { maximum: 255 }
  validates :message, presence: true

  after_create :update_users

  private

  def update_users
    users.update_all('campaign_count = campaign_count + 1')
  end

  def users=users_emails
    users << User.where(email: users_emails)
  end
end
