class Trade < ApplicationRecord
  belongs_to :holding

  after_create_commit { TradeBroadcastJob.perform_later self }
end
