class User < ApplicationRecord
  has_and_belongs_to_many :campaigns

  validates :email, presence: true, uniqueness: true

end
