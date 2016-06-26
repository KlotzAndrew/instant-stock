# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  content    :text
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# messages entered in chat windows
class Message < ApplicationRecord
  after_create_commit { MessageBroadcastJob.perform_later self }
end
