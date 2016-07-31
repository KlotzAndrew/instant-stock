# == Schema Information
#
# Table name: messages
#
#  id           :uuid             not null, primary key
#  portfolio_id :uuid             not null
#  content      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

# messages entered in chat windows
class Message < ApplicationRecord
  belongs_to :portfolio

  validates :portfolio_id, presence: true

  after_create_commit { MessageBroadcastJob.perform_later self }
end
