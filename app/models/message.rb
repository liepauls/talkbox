class Message < ActiveRecord::Base
  belongs_to :room
  belongs_to :user
  validates :text, presence: true
end
