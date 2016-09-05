# == Schema Information
#
# Table name: portfolios
#
#  id              :uuid             not null, primary key
#  name            :string
#  promo_portfolio :boolean          default(FALSE), not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class PortfolioSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :stock_holdings
  has_many :cash_holdings
  has_many :stocks, through: :stock_holdings
  has_many :messages
end
