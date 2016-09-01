# == Schema Information
#
# Table name: cash_trades
#
#  id              :uuid             not null, primary key
#  cash_holding_id :uuid             not null
#  quantity        :decimal(15, 2)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class CashTrade < ApplicationRecord
  belongs_to :cash_holding

  validates :cash_holding_id, presence: true

  alias holding cash_holding
end
