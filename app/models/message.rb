# messages entered in chat windows
class Message < ApplicationRecord
  after_create_commit { MessageBroadcastJob.perform_later self }
end
