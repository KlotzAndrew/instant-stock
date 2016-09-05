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

class CashTradeSerializer < ActiveModel::Serializer
  attributes :id, :cash_holding_id, :quantity, :created_at

  belongs_to :cash_holding
end
