class Message < ApplicationRecord
  validates :content, presence: true
  validates :sender_id, presence: true
  validates :recipient_id, presence: true
  validates :recipient_id, exclusion: { in: lambda{ |message| [message.sender_id] } }
end
