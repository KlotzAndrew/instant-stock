# == Schema Information
#
# Table name: cash_holdings
#
#  id           :uuid             not null, primary key
#  currency     :string           not null
#  portfolio_id :uuid             not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class CashHoldingSerializer < ActiveModel::Serializer
  attributes :id, :currency, :portfolio_id, :current_total

  belongs_to :portfolio
  has_many :cash_trades

  def current_total
    object.current_total
  end
end
